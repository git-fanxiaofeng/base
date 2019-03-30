package io.raycom.modules.sys.notice;

import io.raycom.web.support.mvc.controller.BaseController;
import io.raycom.web.support.utils.user.UserUtils;
import io.raycom.common.config.Global;
import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 公告管理
 * @author zhx，jwz
 */
@Controller
@RequestMapping(value = "${adminPath}/notice")
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
	 * 进入新增页面
	 */
	@RequestMapping(value = "add")
	public String add() {
		return "sys/notice/noticeAdd";
	}
	
	/**
	 * 公告新增保存
	 */
	@RequestMapping(value ="createNoticeDo")
	@ResponseBody
	public String createNoticeDo() {
		String result = noticeService.createNotice(rdata);
		return result;
	}
	
	/**
	 * 公告修改保存
	 */
	@RequestMapping(value ="updateNoticeDo")
	@ResponseBody
	public String updateNoticeDo() {
		String result = noticeService.updateNotice(rdata);
		return result;
	}
	
	/**
	 * 进入公告修改页面
	 * @throws Exception 
	 */
	@RequestMapping(value ="update")
	public String update(Model model) throws Exception {
		RData notice=noticeService.getNotice(rdata);
		model.addAttribute("notice", notice);
		return "sys/notice/noticeDetail";
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value = "delete")
	public String delete(Model model){
		noticeService.deleteNotice(rdata);
		return "sys/notice/noticeList";
	}

}
