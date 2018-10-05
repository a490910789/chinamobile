package cn.test.bus.domain;

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
 * @since 2018-10-05
 */
@TableName("bus_account")
public class Account extends Model<Account> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "aid", type = IdType.INPUT)
    private String aid;
    private String person;
    private String address;
    private Double balance;


    public String getAid() {
        return aid;
    }

    public void setAid(String aid) {
        this.aid = aid;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    @Override
    protected Serializable pkVal() {
        return this.aid;
    }

    @Override
    public String toString() {
        return "Account{" +
        "aid=" + aid +
        ", person=" + person +
        ", address=" + address +
        ", balance=" + balance +
        "}";
    }
}
