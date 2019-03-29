package io.raycom.modules.sys.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.raycom.web.support.mvc.controller.BaseController;
import io.raycom.web.support.security.service.SecurityService;


/**
 * 注册Controller
 * @author wx 
 * @data 2016-4-14
 */
@Controller
@RequestMapping(value = "${frontPath}/sys/register")
public class RegisterController extends BaseController{
	@Autowired
	private RegisterService registerService ;
	
	@RequestMapping(value={"list",""})
	public String list(Model model){
		return "sys/register/registerList";
	}
	
	@RequestMapping(value="createRegisterDo")
	@ResponseBody
	public String createRegisterDo(){
		//将密码加密处理
		String password = SecurityService.entryptPassword(rdata.getString("password"));
		rdata.set("password", password);
		return registerService.createRegisterDo(rdata);
	}
}
