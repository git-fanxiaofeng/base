package io.raycom.modules.sys.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import io.raycom.business.jms.send.usc.register.authCodeRegStatus.AuthCodeRegStatusSender;
//import io.raycom.components.qcc.QccRest;
import io.raycom.core.collection.RData;
import io.raycom.utils.string.StringUtils;
import io.raycom.web.service.BaseService;

@Service
@Transactional(readOnly = true)
public class RegisterService extends BaseService {
	
	@Autowired
	private RegisterDao registerDao;
	
//	@Autowired
//	private QccRest qccRest;
	
//	@Autowired
//	private AuthCodeRegStatusSender authcodeRegStatusSender;
	
	public String createRegisterDo(RData rdata) {
		
		String registerValidMsg = registerValid(rdata);
		if(registerValidMsg!=null){
			return registerValidMsg;
		}
		
		//生成供应商id
		String vendorId=registerDao.getVendorId();
		rdata.setString("vendorId", vendorId);
		
		//插入用户表
		registerDao.createUserDo(rdata);
		rdata.setString("roleId", "10000120");//为供应商注册用户赋予“临时用户”权限，“临时用户”role_id为
		registerDao.grantPrivilegetoUser(rdata);
		
		if(!StringUtils.isEmpty(rdata.getString("authorizationCode"))){
			rdata.setString("applyStatus", "05");//设置供应关系为待审批
			registerDao.updateAuthorizationDo(rdata);//更新授权码表(公司编码、公司名称、授权码使用状态、更新日期、更新人)
			registerDao.createVendorHospital(rdata);
//			authcodeRegStatusSender.sendMsg(rdata);//调用接口将授权码使用状态变为“已使用”
			
			rdata.setString("dataSources", "USC");
		}else {
			rdata.setString("dataSources", "UPS");
		}
		
		rdata.setString("extApproveStatus", "toBeSubmit");
		registerDao.createRegisterDo(rdata);//插入注册表(tb_ups_register)
		
		/*//调用接口获取供应商基础数据
		RData vendorInfo = qccRest.getVendorBasicInfo(rdata.getString("vendorName").trim());
		if("200".equals(vendorInfo.getString("status"))){//若能查到
			rdata.set("dataMode", "qcc");
			rdata.set("companyType", vendorInfo.getString("companyType"));
			rdata.set("area", vendorInfo.getString("area"));
			rdata.set("address", vendorInfo.getString("address"));
			rdata.set("corporation", vendorInfo.getString("corporation"));
			rdata.set("registeredFund", vendorInfo.getString("registeredFund"));
			rdata.set("taxId", vendorInfo.getString("taxId"));
		}*/
		//插入供应商基本信息审批表(tb_ups_vendor_apply)
		registerDao.createVendorApproveDo(rdata);
		return "true";
	}
	
	/*
	 * 校验
	 */
	public String registerValid(RData rdata){
		if(registerDao.isVendorRegistered(rdata)>0){
			return "您输入的供应商已注册，不需要再次注册，如您忘记登录账号请与平台联系！";
		}
		
		if(!StringUtils.isEmpty(rdata.getString("authorizationCode"))){
			//填写授权码时验证
			RData codeStatus = registerDao.getAuthorizationCodeStatus(rdata);
			if(codeStatus==null){
				return "您的邀请码与供应商名称匹配有误，请确认您输入的邀请码是否正确！";
			}
			if("O".equals(codeStatus.getString("isUse"))){
				return "您输入的邀请码已失效，请确认！";
			}
			rdata.set("orgId", codeStatus.getString("orgId"));
		}
		
		
		if(registerDao.isLoginNameRegistered(rdata)!=null){
			return "您输入的登录账号已经存在，请重新输入!";
		}
		
		return null;
	}
	
}
