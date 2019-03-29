package io.raycom.modules.sys.hospital;

import io.raycom.web.support.mvc.controller.BaseController;
import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 医院基本信息管理
 * @author 孙莉然
 * @date 2016-04-11
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/hospital")
public class HospitalController extends BaseController{
	
	@Autowired
	private HospitalService hospitalService;
	
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "sys/hospital/hospitalList";
	}
	
	@RequestMapping(value ="queryHospitalList")
	@ResponseBody
	public Page<RData> queryHospitalList(){
		hospitalService.queryHospitalList(page);
		return page;
	}
	
	/*
	 * 进入新增界面
	 */
	@RequestMapping(value ="add")
	public String create() {
		return "sys/hospital/hospitalAdd";
	}
	
	@RequestMapping(value ="createHospitalDo")
	public String createHospitalDo() {
		hospitalService.createHospital(rdata);
		return "sys/hospital/hospitalList";
	}
	
	/*
	 * 进入修改界面
	 */
	@RequestMapping(value ="update")
	public String updateHospital(Model model) {
		RData data = hospitalService.queryHospitalDetial(rdata);
		model.addAttribute("data", data);
		return "sys/hospital/hospitalUpdate";
	}
	
	@RequestMapping(value="updateHospitalDo")
	public String updateHospitalDo(){
		hospitalService.updateHospital(rdata);
		return "sys/hospital/hospitalList";
	}
}
