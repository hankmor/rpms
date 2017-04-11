package dendy.rpms.domain;

/**
 * 下拉框查询对象
 *
 * @author ChengJianLong
 * @since 2014年01月23日
 */
public class SelectObject {
    private Object key;
    private Object value;

    public SelectObject() {}

    public SelectObject(Object key, Object value) {
        this.key = key;
        this.value = value;
    }

    public Object getKey() {
        return key;
    }

    public void setKey(Object key) {
        this.key = key;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }
}
