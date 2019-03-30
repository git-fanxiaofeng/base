package io.raycom.modules.sys.notice;

import io.raycom.web.service.BaseService;
import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 公告管理
 * @author zhx
 *
 */
@Service
@Transactional(readOnly = true)
public class NoticeService extends BaseService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	/**
	 * 获取公告列表
	 * @param page
	 */
	public void getAllList(Page<RData> page){
		page.setData(noticeDao.getAllList(page));
	}
	
	/**
	 * 新增公告
	 * @param rdata
	 * @return
	 */
	public String createNotice(RData rdata) {
		//1.创建公告主键
		String noticeId = noticeDao.queryNoticeId();
		rdata.set("noticeId", noticeId);
		//2.新增公共
		noticeDao.createNoticeDo(rdata);
		//3.公告发布的系统是UPS，调用接口将公告信息推送至UPS
		return "ok";
	}

	/**
	 * 更新公告
	 * @param rdata
	 * @return
	 */
	public String updateNotice(RData rdata) {
		noticeDao.updateNoticeDo(rdata);
		return "ok";
	}
	
	/**
	 * 删除公告
	 * @param rdata
	 */
	public void deleteNotice(RData rdata) {
		noticeDao.delete(rdata);
	}
	
	/**
	 * 查询数据用于接口传输
	 * @param rdata
	 * @return
	 */
	public RData queryNoticeById(RData rdata) {
		return noticeDao.queryNoticeById(rdata);
	}
	
	/**
	 * 详情查询
	 * @param rdata
	 * @return
	 */
	public RData getNotice(RData rdata) {
		return noticeDao.getNotice(rdata);
	}
	
	
}
