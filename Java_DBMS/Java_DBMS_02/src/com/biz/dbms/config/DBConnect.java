package com.biz.dbms.config;

public class DBConnect {
	
	private String configFile;
	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		configFile = 'com/biz/order/config/bybatis-context.xml';
		InputStream inputStream = null;
		inputStream = Resources.getResourceAsStream(configFile);
	}
	

}
