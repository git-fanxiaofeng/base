package io.raycom.modules.sys.organization;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.raycom.core.collection.RData;
import io.raycom.web.support.mvc.controller.BaseController;

/**
 * 组织结构/部门管理
 * @author ly
 * @date 2016-04-15
 * @version 1.0.0
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/organization")
public class OrganizationController extends BaseController {

	@Autowired
	private OrganizationService organizationService;
	
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "sys/organization/organizationList";
	}
	
	/**
	 * 加载页面组织结构菜单树
	 * @return
	 */
	@RequestMapping(value ="organizationTree")
	@ResponseBody
	public ArrayList<RData> organizationTree(Model model) {
		return organizationService.organizationTree();
	}
	
	/**
	 * 查询组织详情
	 * @return
	 */
	@RequestMapping(value="queryByOrgId")
	@ResponseBody
	public RData queryByOrgId(Model model){
		rdata = organizationService.queryByOrgId(rdata);
		return rdata ;
	}
	
	/**
	 * 保存组织信息，如果存在则修改；不存在则插入
	 * @return
	 */
	@RequestMapping(value ="addOrganization")
	@ResponseBody
	public String addOrganization() {
		if (rdata.getString("orgId") == "") {
			organizationService.addOrganization(rdata);
		} else {
			organizationService.updateOrganization(rdata) ;
		}
		return "";
	}
	
	/**
	 * 删除组织,这里只做逻辑删除，不做物理删除，即将del_flag状态改为Y
	 * @return
	 */
	@RequestMapping(value ="delete")
	@ResponseBody
	public String delete() {
		organizationService.deleteOrganization(rdata);
		return "" ;
	}
		
}
