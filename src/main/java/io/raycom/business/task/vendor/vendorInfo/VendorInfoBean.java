package io.raycom.business.task.vendor.vendorInfo;

import java.util.ArrayList;

import io.raycom.context.bean.MsgBean;
import io.raycom.core.collection.RData;


/**
 * 供应商信息bean
 */
public class VendorInfoBean implements MsgBean{
	private String vendorApplyId;
	private String vendorId;
	private String vendorChName;
	private String orgId;
	private String nation;
	private String area;
	private String officeAddress;
	private String registeredAddress;
	private String registeredFund;
	private String corporation;
	private String introduction;
	private String companyType;
	private String toleranceRange;
	private String taxId;
	private String contact1;
	private String tel1;
	private String email1;
	private String contact2;
	private String email2;
	private String tel2;
	private String status;
	private String baseStatus;
	private String baseApprover;
	private String baseApproveOption;
	private String approver;
	private String approveOption;
	
	ArrayList<VendorCertBean> cert= new ArrayList<VendorCertBean>();
    ArrayList<CertUnitMstBean> certUnitMst= new ArrayList<CertUnitMstBean>();
	ArrayList<CertUnitDtlBean> certUnitDtl= new ArrayList<CertUnitDtlBean>();
    
	public String getVendorApplyId() {
		return vendorApplyId;
	}
	public void setVendorApplyId(String vendorApplyId) {
		this.vendorApplyId = vendorApplyId;
	}
	public String getVendorId() {
		return vendorId;
	}
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	public String getVendorChName() {
		return vendorChName;
	}
	public void setVendorChName(String vendorChName) {
		this.vendorChName = vendorChName;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getOfficeAddress() {
		return officeAddress;
	}
	public void setOfficeAddress(String officeAddress) {
		this.officeAddress = officeAddress;
	}
	public String getRegisteredAddress() {
		return registeredAddress;
	}
	public void setRegisteredAddress(String registeredAddress) {
		this.registeredAddress = registeredAddress;
	}
	public String getRegisteredFund() {
		return registeredFund;
	}
	public void setRegisteredFund(String registeredFund) {
		this.registeredFund = registeredFund;
	}
	public String getCorporation() {
		return corporation;
	}
	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getCompanyType() {
		return companyType;
	}
	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}
	public String getToleranceRange() {
		return toleranceRange;
	}
	public void setToleranceRange(String toleranceRange) {
		this.toleranceRange = toleranceRange;
	}
	public String getTaxId() {
		return taxId;
	}
	public void setTaxId(String taxId) {
		this.taxId = taxId;
	}
	public String getContact1() {
		return contact1;
	}
	public void setContact1(String contact1) {
		this.contact1 = contact1;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getContact2() {
		return contact2;
	}
	public void setContact2(String contact2) {
		this.contact2 = contact2;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBaseStatus() {
		return baseStatus;
	}
	public void setBaseStatus(String baseStatus) {
		this.baseStatus = baseStatus;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public String getApproveOption() {
		return approveOption;
	}
	public void setApproveOption(String approveOption) {
		this.approveOption = approveOption;
	}
	public String getBaseApprover() {
		return baseApprover;
	}
	public void setBaseApprover(String baseApprover) {
		this.baseApprover = baseApprover;
	}
	public String getBaseApproveOption() {
		return baseApproveOption;
	}
	public void setBaseApproveOption(String baseApproveOption) {
		this.baseApproveOption = baseApproveOption;
	}
	public ArrayList<VendorCertBean> getCert() {
		return cert;
	}
	public void setCert(ArrayList<VendorCertBean> cert) {
		this.cert = cert;
	}
	public ArrayList<CertUnitMstBean> getCertUnitMst() {
		return certUnitMst;
	}
	public void setCertUnitMst(ArrayList<CertUnitMstBean> certUnitMst) {
		this.certUnitMst = certUnitMst;
	}
	public ArrayList<CertUnitDtlBean> getCertUnitDtl() {
		return certUnitDtl;
	}
	public void setCertUnitDtl(ArrayList<CertUnitDtlBean> certUnitDtl) {
		this.certUnitDtl = certUnitDtl;
	}
	@Override
	public void init(RData rData) {

	}
	@Override
	public RData toRData() {
		RData rData = new RData();
		rData.set("vendorApplyId", this.getVendorApplyId());
		rData.set("vendorId", this.getVendorId());
		rData.set("vendorChName", this.getVendorChName());
		rData.set("orgId", this.getOrgId());
		rData.set("nation", this.getNation());
		rData.set("area", this.getArea());
		rData.set("officeAddress", this.getOfficeAddress());
		rData.set("registeredAddress", this.getRegisteredAddress());
		rData.set("registeredFund", this.getRegisteredFund());
		rData.set("corporation", this.getCorporation());
		rData.set("introduction", this.getIntroduction());
		rData.set("companyType", this.getCompanyType());
		rData.set("toleranceRange", this.getToleranceRange());
		rData.set("taxId", this.getTaxId());
		rData.set("contact1", this.getContact1());
		rData.set("tel1", this.getTel1());
		rData.set("email1", this.getEmail1());
		rData.set("contact2", this.getContact2());
		rData.set("tel2", this.getTel2());
		rData.set("email2", this.getEmail2());
		rData.set("status", this.getStatus());
		rData.set("baseStatus", this.getBaseStatus());
		rData.set("approver", this.getApprover());
		rData.set("approveOption", this.getApproveOption());
		rData.set("baseApprover",this.getBaseApprover());
		rData.set("baseApproveOption",this.getBaseApproveOption());
		rData.set("cert",this.getCert());
        rData.set("certUnitMst",this.getCertUnitMst());
        rData.set("certUnitDtl",this.getCertUnitDtl());
		return rData;
	}
}

