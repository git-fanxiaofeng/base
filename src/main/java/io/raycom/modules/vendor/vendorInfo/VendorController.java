package io.raycom.modules.vendor.vendorInfo;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.raycom.core.collection.RData;
import io.raycom.modules.vendor.util.VendorUtil;
import io.raycom.web.bean.Page;
import io.raycom.web.support.mvc.controller.BaseController;

/**
 * 供应商信息查询
 * @author fxf
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/vendor")
public class VendorController extends BaseController{
	
	@Autowired
	private VendorService vendorService;
	
	/*
	 * 进入初始界面
	 */
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		return "vendor/vendorInfo/vendorList";
	}
	
	/*
	 * 返回page
	 */
	@RequestMapping(value = "queryVendorList")
	@ResponseBody
	public Page<RData> queryVendorList() {
		vendorService.queryVendorList(page);
		return page;
	}
	
	/*
	 * 进入详情页面
	 */
	@RequestMapping(value="vendorDetail")
	public String vendorDetail(Model model){
		model.addAttribute("data", rdata);
		return "vendor/vendorInfo/vendorDetail";
	}
	
	/*
	 * 查询资质管理单元审批表主表
	 */
	@RequestMapping(value="queryVH")
	@ResponseBody
	public RData queryVH(){
		RData vh = vendorService.queryVh(rdata);
		ArrayList<RData> certUnitTemp = vendorService.queryVhCert(rdata);
		vh.set("companys", VendorUtil.getCertUnitData(certUnitTemp));
		return vh;	
	}
	
	
}
