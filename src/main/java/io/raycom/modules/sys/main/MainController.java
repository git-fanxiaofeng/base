package io.raycom.modules.sys.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.raycom.core.collection.RData;
import io.raycom.web.support.mvc.controller.BaseController;

/**
 * index方法
 * @author likexin
 * @date 2018-11-20
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/main")
public class MainController extends BaseController {
	
	@Autowired
	private MainService mainService;
	
	/**
	 * 获取未读的公告
	 */
	@RequestMapping(value = "getUnreadNotice")
	@ResponseBody
	public String getUnreadNotice(){
		return mainService.getUnreadNoticeId(rdata);
	}
	
	@RequestMapping(value="noticePopup")
	public String noticePopup(Model model){
		RData notice = mainService.queryNotice(rdata);
		model.addAttribute("notice",notice);
		return "sys/main/noticePopup";
	}

}
