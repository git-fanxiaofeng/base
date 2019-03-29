package io.raycom.business.support.email.base;


import io.raycom.business.support.email.base.SendEmail;

/**
 * 邮件发送
 * @author likexin
 * @date 2017年9月26日
 * @version 1.0.0
 */
public class EmailHelper{
	
	public static SendEmail sendEmail(){
		return new SendEmail();
	}
}
