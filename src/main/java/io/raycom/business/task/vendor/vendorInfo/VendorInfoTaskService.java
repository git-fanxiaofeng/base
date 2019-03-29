package io.raycom.business.task.vendor.vendorInfo;



import io.raycom.core.collection.RData;
import io.raycom.web.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class VendorInfoTaskService extends BaseService {

	@Autowired
	private VendorInfoTaskDao vendorInfoTaskDao;
	
	public void manage(VendorInfoBean vendorInfo){
		//供应商信息
		RData vendor=vendorInfo.toRData();
		RData tmp=new RData();
		//判断是否存在该供应商
		if(vendorInfoTaskDao.checkVendor(vendor)>0){
			//供应商信息处理
			vendorInfoTaskDao.updateVendorApply(vendor);
			//将现有使用中的资质全部删除
			vendorInfoTaskDao.deleteCertApplyAll(vendor);
			vendorInfoTaskDao.deleteCertUnitMstApplyAll(vendor);
			vendorInfoTaskDao.deleteCertUnitDtlApplyAll(vendor);
			//资质信息处理
			for (VendorCertBean certBean : vendorInfo.getCert()) {
				tmp=certBean.toRData();
				vendorInfoTaskDao.updateCertApply(tmp);
			}
			//资质单元主表处理
			for (CertUnitMstBean certUnitMstBean : vendorInfo.getCertUnitMst()) {
				tmp=certUnitMstBean.toRData();
				vendorInfoTaskDao.updateCertUnitMstApply(tmp);
			}
			//资质单元子表处理
			for (CertUnitDtlBean certUnitDtlBean : vendorInfo.getCertUnitDtl()) {
				tmp=certUnitDtlBean.toRData();
				vendorInfoTaskDao.updateCertUnitDtlApply(tmp);
			}
		}else{
			//供应商信息处理
			vendorInfoTaskDao.insertVendor(vendor);
			vendorInfoTaskDao.insertVendorHis(vendor);
			vendorInfoTaskDao.insertVh(vendor);
			//供应商资质处理
			for (VendorCertBean certBean : vendorInfo.getCert()) {
				tmp=certBean.toRData();
				vendorInfoTaskDao.insertVendorCert(vendor);
				vendorInfoTaskDao.insertVendorCertHis(vendor);
				vendorInfoTaskDao.insertVhCert(vendor);
			}
			//资质单元主表处理
			for (CertUnitMstBean certUnitMstBean : vendorInfo.getCertUnitMst()) {
				tmp=certUnitMstBean.toRData();
				vendorInfoTaskDao.insertCertUnitMst(tmp);
				vendorInfoTaskDao.insertCertUnitMstHis(tmp);
				vendorInfoTaskDao.insertVhCertUnitMst(tmp);
			}
			//资质单元子表处理
			for (CertUnitDtlBean certUnitDtlBean : vendorInfo.getCertUnitDtl()) {
				tmp=certUnitDtlBean.toRData();
				vendorInfoTaskDao.insertCertUnitDtl(tmp);
				vendorInfoTaskDao.insertCertUnitDtlHis(tmp);
				vendorInfoTaskDao.insertVhCertUnitdtl(vendor);
			}
		}
		
		
	}
		
}

