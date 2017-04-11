package dendy.rpms.page;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;

/**
 * 查询对象
 *
 * @author Dendy
 * @since 2014-2-18 12:56:01
 */
public abstract class ObjectQuery {
    // 起始页数
    private int page = 1;
    // 每一页显示条数
    private int rows = 10;
    // 排序字段
    private String sort;
    // 排序方式：asc,desc
    private String order;

    /**
     * 子类实现，<b>通过QBC方式拼装查询条件并返回DetachedCriteria对象.</b>
     */
    public abstract DetachedCriteria getDetachedCriteria();

    /**
     * 查询时前端封装后的显示对象
     */
    private Class domainClass;

    /**
     * 设置查询结果投影，要求必须设置投影，查询业务需要的字段，从而提高效率。
     *
     * @return
     */
    public ProjectionList projectionList() {
        return null;
    }

    /**
     * 设置前端显示的类，用于查询时将投影转换为该类型，如果返回null，则会映射到原始后台model.
     * <p/>
     * eg.
     * <blockquote>
     * criteria.setResultTransformer(Transformers.aliasToBean(bean));
     * </blockquote>
     *
     * @return 前端显示的domain对象
     * @see org.hibernate.Criteria#setResultTransformer(org.hibernate.transform.ResultTransformer)
     */
    public Class getDomainClass() {
        return null;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }
}
