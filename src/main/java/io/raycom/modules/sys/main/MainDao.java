package io.raycom.modules.sys.main;

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
public interface MainDao {

	RData getUserNotice(RData rdata);

	RData getUnreadNotice(RData rdata);

	void insertNoticeRead(RData rdata);

	RData queryNotice(RData rdata);

}
