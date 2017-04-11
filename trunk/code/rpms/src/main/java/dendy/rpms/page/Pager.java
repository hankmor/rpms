package dendy.rpms.page;

import java.util.Collections;
import java.util.List;

/**
 * 分页对象
 *
 * @author Dendy
 * @since 2014-2-18 12:56:14
 */
public class Pager<T> {
    // 总的记录数
    private long total;
    // 数据
    private List<T> rows = Collections.emptyList();

    public Pager() {}

    public Pager(long total) {
        this.total = total;
    }

    public Pager(long total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
