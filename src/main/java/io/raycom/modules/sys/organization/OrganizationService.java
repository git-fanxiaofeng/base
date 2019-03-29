package io.raycom.modules.sys.organization;

import io.raycom.web.service.BaseService;
import io.raycom.core.collection.RData;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional(readOnly = true)
public class OrganizationService extends BaseService {
	
	@Autowired
	private OrganizationDao organizationDao;
	
	public ArrayList<RData> organizationTree() {
		return organizationDao.organizationTree();
	}
	
	public RData queryByOrgId(RData rdata) {
		return organizationDao.queryByOrgId(rdata);
	}
	
	public void addOrganization(RData rdata) {
		organizationDao.addOrganization(rdata);
	}
	
	public void updateOrganization(RData rdata) {
		organizationDao.updateOrganization(rdata) ;
	}
	
	public void deleteOrganization(RData rdata) {
		organizationDao.deleteOrganization(rdata);
	}
	
	
	
}
