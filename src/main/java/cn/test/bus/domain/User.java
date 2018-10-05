package cn.test.bus.domain;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author chen
 * @since 2018-10-04
 */
@TableName("bus_user")
public class User extends Model<User> {

	private static final long serialVersionUID = 1L;

	@TableId(value = "uid", type = IdType.AUTO)
	private Integer uid;
	private String phone;
	private String roaming;
	private String calllevel;
	private Integer customerid;
	private String accountid;
	/*private String cname;
	private Double balance;*/

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRoaming() {
		return roaming;
	}

	public void setRoaming(String roaming) {
		this.roaming = roaming;
	}

	public String getCalllevel() {
		return calllevel;
	}

	public void setCalllevel(String calllevel) {
		this.calllevel = calllevel;
	}

	public Integer getCustomerid() {
		return customerid;
	}

	public void setCustomerid(Integer customerid) {
		this.customerid = customerid;
	}

	public String getAccountid() {
		return accountid;
	}

	public void setAccountid(String accountid) {
		this.accountid = accountid;
	}

	@Override
	protected Serializable pkVal() {
		return this.uid;
	}

}
