
package io.raycom.modules.sys.user;

import io.raycom.utils.string.StringUtils;
import io.raycom.web.support.mvc.controller.BaseController;
import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.support.security.service.SecurityService;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 用户Controller
 * @author wx 
 * @data 2016-4-14
 */
@Controller
@RequestMapping(value = "${adminPath}/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;
	
	/*
	 * 进入初始界面
	 */
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		return "sys/user/userList";
	}
	
	@RequestMapping(value = "queryUserList")
	@ResponseBody
	public Page<RData> queryUserList() {
		userService.getAllUser(page);
		return page;
	}

	/*
	 * 获取所有部门，用于树形显示
	 * 
	 */
	@RequestMapping(value ="getAllOfficeNodes")
	@ResponseBody
	public List<RData> getAllOfficeNodes(){
		return userService.getOfficeList();
	}
	
	/*
	 * 进入新增界面
	 */
	@RequestMapping(value ="add")
	public String add(Model model) {
		ArrayList<RData> roleList=userService.getRoleList();
		model.addAttribute("role", roleList);
		return "sys/user/userAdd";
	}
	
	/*
	 * 新增用户
	 */
	@RequestMapping(value ="createUserDo")
	@ResponseBody
	public String createUserDo() {
		String password = SecurityService.entryptPassword(rdata.getString("password"));
		rdata.set("password", password);
		return userService.createUserDo(rdata);
	}
	
	/*
	 * 进入修改界面
	 */
	@RequestMapping(value ="update")
	public String update(Model model) {
		ArrayList<RData> exceptRole=userService.getExceptRoleList(rdata);
		ArrayList<RData> userRole = userService.getUserRole(rdata);
		exceptRole.addAll(userRole);
		RData  user=userService.getUser(rdata);
		model.addAttribute("exceptRole", exceptRole);
		
		model.addAttribute("user", user);
		String roleId="";
		if(userRole != null && userRole.size() > 0){
			for (Iterator iterator = userRole.iterator(); iterator.hasNext();) {
				RData rData = (RData) iterator.next();
				roleId+=(rData.getString("roleId")+",");
			}
			roleId = roleId.substring(0,roleId.length()-1);
		}
		model.addAttribute("userRole", roleId);
		return "sys/user/userUpdate";
	}
	
	
	/*
	 * 修改用户信息
	 */
	@RequestMapping(value ="updateUserDo")
	@ResponseBody
	public void updateUserDo() {
		if(!StringUtils.isEmpty(rdata.getString("password"))){
			rdata.set("password", SecurityService.entryptPassword(rdata.getString("password")));
		}
		userService.updateUserDo(rdata);
	}
	
	/*
	 * 删除用户以及角色
	 */
	@RequestMapping(value ="deleteUserDo")
	public String deleteUserDo() {
		userService.deleteUser(rdata);
		userService.deleteUserRole(rdata);
		return "sys/user/userList";
	}
	
	/**
	 * 重置密码
	 */
	@RequestMapping(value ="resetPass")
	@ResponseBody
	public String resetPass() {
		String password = SecurityService.entryptPassword("123456");
		rdata.set("password", password);
		return userService.resetPwd(rdata);
	}
	
	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping(value="updatePwd")
	public String updatePwd(Model model){
		model.addAttribute("user",userService.queryUserName(rdata));
		return "sys/user/pwdUpdate";
	}
	
	/**
	 * 保存修改的密码
	 * @return
	 */
	@RequestMapping(value="saveUpdatedPwd")
	@ResponseBody
	public String saveUpdatedPwd(){
		if (SecurityService.validatePassword(rdata.getString("oldPassword"), userService.queryUserPwd(rdata))) {
			//修改密码
			rdata.setString("newPassword", SecurityService.entryptPassword(rdata.getString("newPassword")));
			return userService.saveUpdatedPwd(rdata);
		}else {
			//原密码错误
			return "oldPasswordError";
		}
	}
	
}
