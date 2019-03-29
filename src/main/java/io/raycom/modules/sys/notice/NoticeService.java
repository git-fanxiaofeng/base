package io.raycom.modules.sys.notice;

import io.raycom.web.service.BaseService;
import io.raycom.core.collection.RData;
import io.raycom.core.collection.RMultiData;
import io.raycom.web.bean.Page;

import java.sql.Clob;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 公告管理
 * @author liyuan
 * @date 2016-04-14
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class NoticeService extends BaseService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	public void getAllList(Page<RData> page){
		page.setData(noticeDao.getAllList(page));
	}

	public RData getNotice(RData rdata) {
		RData notice =  noticeDao.getNotice(rdata);
		notice.setString("noticeContent", oracleClob2Str((Clob)notice.get("noticeContent")));
		return notice;
	}

	public String oracleClob2Str(Clob clob)  {
		try {
			return (clob != null ? clob.getSubString(1, (int) clob.length()): null);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "";
	}


}
