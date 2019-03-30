package io.raycom.modules.sys.notice;

import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.persistence.annotation.MyBatisDao;

import java.util.ArrayList;

/**
 * 公告管理
 * @author liyuan
 * @date 2016-04-14
 * @version 1.0.0
 */
@MyBatisDao
public interface NoticeDao {

	ArrayList<RData> getAllList(Page<RData> page);

	void createNoticeDo(RData rdata);

	RData getNotice(RData rdata);

	void delete(RData rdata);

	void updateNoticeDo(RData rdata);

	String queryNoticeId(RData rdata);

	RData queryNoticeById(RData rdata);

	String queryNoticeId();

}
