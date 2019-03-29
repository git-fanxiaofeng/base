package io.raycom.modules.sys.register;

import io.raycom.core.collection.RData;
import io.raycom.web.persistence.annotation.MyBatisDao;
/**
 * 注册Dao接口
 * @author wx
 *
 */
@MyBatisDao
public interface RegisterDao {

	public void createRegisterDo(RData rdata);
	public void createUserDo(RData rdata);
	public void updateAuthorizationDo(RData rdata);
	public void createVendorApproveDo(RData rdata);
	public void grantPrivilegetoUser(RData rdata);
	public String getVendorId();
	public RData getAuthorizationCodeStatus(RData rdata);
	public int isVendorRegistered(RData rdata);
	public String isLoginNameRegistered(RData rdata);
	public void createVendorHospital(RData rdata);
}
