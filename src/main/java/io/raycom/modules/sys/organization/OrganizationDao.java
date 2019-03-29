package io.raycom.modules.sys.organization;

import java.util.ArrayList;

import io.raycom.core.collection.RData;
import io.raycom.web.persistence.annotation.MyBatisDao;


@MyBatisDao
public interface OrganizationDao{
	
	public ArrayList<RData> organizationTree();
	
	public RData queryByOrgId(RData rdata);
	
	public void addOrganization(RData rdata);
	
	public void updateOrganization(RData rdata) ;
	
	public void deleteOrganization(RData rdata);
	
}
