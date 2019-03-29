package io.raycom.modules.sys.notice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.support.mvc.controller.BaseController;

/**
 * 公告管理
 * @author liyuan
 * @date 2016-04-14
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/notice")
public class NoticeController extends BaseController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 进入列表页面
	 */
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "sys/notice/noticeList";
	}
	
	/**
	 * 列表信息查询结果
	 */
	@RequestMapping(value = "queryNoticeList")
	@ResponseBody
	public Page<RData> queryNoticeList() {
		noticeService.getAllList(page);
		return page;
	}
	
	/**
	 * 进入公告修改页面
	 */
	@RequestMapping(value ="update")
	public String update(Model model) {
		RData notice=noticeService.getNotice(rdata);
		model.addAttribute("notice", notice);
		return "sys/notice/noticeUpdate";
	}
	
	/**
	 * 进入公告修改页面
	 */
	@RequestMapping(value ="detail")
	public String detail(Model model) {
		RData notice=noticeService.getNotice(rdata);
		model.addAttribute("notice", notice);
		return "sys/notice/noticeDetail";
	}
	

}
