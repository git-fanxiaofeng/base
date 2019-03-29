package io.raycom.modules.sys.user;

import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.persistence.annotation.MyBatisDao;

import java.util.ArrayList;
/**
 * 用户Dao接口
 * @author wx
 *
 */
@MyBatisDao
public interface UserDao {
	
	public ArrayList<RData> getAllUser(Page<RData> page);
	
	public ArrayList<RData> getOfficeList();
	
	public ArrayList<RData> getRoleList();
	
	public ArrayList<RData> getExceptRoleList(RData rdata);
	
	public ArrayList<RData> getUserRole(RData rdata);
	
	public RData getUser(RData rdata);
	
	public void createUserDo(RData rdata);
	
	public void createUserRole(RData rdata);
	
	public void updateUser(RData rdata);
	
	public RData checkLoginName(RData rdata);
	
	public void deleteUser(RData rdata);
	
	public void deleteUserRole (RData rdata);
	
	public void resetPwd(RData rdata);
}
