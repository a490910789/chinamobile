package cn.test.sys.constast;

public interface SYS_Constast {

	/**
	 * 用户类型
	 */
	public static final Integer USER_TYPE_SUPER = 0;
	public static final Integer USER_TYPE_NORMAL = 1;

	/**
	 * 可用类型
	 */
	public static final Integer TYPE_AVAILABLE_YES = 1;
	public static final Integer TYPE_AVAILABLE_NO = 0;

	/**
	 * 公用类型
	 */
	public static final Integer TYPE_PUBLIC_ZERO = 0;
	public static final Integer TYPE_PUBLIC_ONE = 1;
	public static final Integer TYPE_PUBLIC_TOW = 2;
	
	/**
	 * 漫游状态
	 */
	public static final Character TYPE_ROAMING_STATE_PROVINCE = 'p';
	public static final Character TYPE_ROAMING_STATE_DOMESTIC = 'd';
	public static final Character TYPE_ROAMING_STATE_INTERNATIONAL = 'i';
	/**
	 * 业务类型
	 */
	public static final Character TYPE_BUS_OPEN = 'A';
	public static final Character TYPE_BUS_ROAMING = 'B';
	public static final Character TYPE_BUS_DEPOSIT = 'C';
	public static final Character TYPE_BUS_NETIN = 'D';
	public static final Character TYPE_BUS_SELECTCAR = 'E';

	/**
	 * 用户默认密码
	 */
	public static final String USER_DEFAULT_PWD = "123456";
	
}
