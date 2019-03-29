package io.raycom.modules.sys.main;

import java.sql.Clob;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import io.raycom.core.collection.RData;
import io.raycom.utils.string.StringUtils;
import io.raycom.web.service.BaseService;

/**
 * 公告管理
 * @author liyuan
 * @date 2016-04-14
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class MainService extends BaseService {
	
	@Autowired
	private MainDao mainDao;

	public String getUnreadNoticeId(RData rdata) {
		//获取最新的创建时间
		RData createDate = mainDao.getUserNotice(rdata);
		RData notice = mainDao.getUnreadNotice(createDate);
		
		if(notice!=null) {
			notice.set("currentUser", rdata.getString("currentUser"));
			mainDao.insertNoticeRead(notice);
			return notice.getString("noticeId");
		}

		return "";
	}


	public RData queryNotice(RData rdata) {
		RData notice = mainDao.queryNotice(rdata);
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
