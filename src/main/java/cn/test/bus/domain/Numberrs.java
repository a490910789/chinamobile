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
 * @since 2018-10-04
 */
@TableName("bus_numberrs")
public class Numberrs extends Model<Numberrs> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "phonenumber", type = IdType.AUTO)
    private String phonenumber;
    private String phonetype;
    private String carnumber;
    private Integer available;


    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getPhonetype() {
        return phonetype;
    }

    public void setPhonetype(String phonetype) {
        this.phonetype = phonetype;
    }

    public String getCarnumber() {
        return carnumber;
    }

    public void setCarnumber(String carnumber) {
        this.carnumber = carnumber;
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }

    @Override
    protected Serializable pkVal() {
        return this.phonenumber;
    }

    @Override
    public String toString() {
        return "Numberrs{" +
        "phonenumber=" + phonenumber +
        ", phonetype=" + phonetype +
        ", carnumber=" + carnumber +
        ", available=" + available +
        "}";
    }
}
