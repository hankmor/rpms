package dendy.rpms.dao.base;

import dendy.rpms.page.Pager;
import dendy.rpms.utils.CollectionUtils;
import org.hibernate.*;
import org.hibernate.criterion.*;
import org.hibernate.engine.SessionFactoryImplementor;
import org.hibernate.hql.ast.QueryTranslatorImpl;
import org.hibernate.jdbc.Work;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * 基础DAO实现
 *
 * @author Dendy
 * @since 2014-2-18 12:51:38
 */
@Repository
public class BaseDao {

    @Autowired
    private HibernateTemplate hibernateTemplate;
    @Autowired
    private SessionFactory sessionFactory;

    private static final Logger LOG = LoggerFactory.getLogger(BaseDao.class);

    /**
     * 获取hibernatetemplate
     *
     * @return hibernateTemplate
     */
    protected HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    /**
     * 获取sessionFactory
     *
     * @return sessionFactory
     */
    protected SessionFactory getSessionFactory() {
        return this.getHibernateTemplate().getSessionFactory();
    }

    /**
     * 获取session
     *
     * @return session
     */
    protected Session getSession() {
        return this.getSessionFactory().getCurrentSession();
    }

    /**
     * 获取Query
     *
     * @param hql hql
     * @return Query
     */
    public Query getQuery(String hql) {
        return this.getSession().createQuery(hql);
    }

    /**
     * 获取SQLQuery
     *
     * @param sql sql
     * @return SQLQuery
     */
    public SQLQuery getSQLQuery(String sql) {
        return this.getSession().createSQLQuery(sql);
    }

    /**
     * 获取Criteria
     *
     * @param entityClass 泛型类
     * @param <T>         对象类型
     * @return Criteria
     */
    public <T> Criteria getCriteria(Class<T> entityClass) {
        return this.getSession().createCriteria(entityClass);
    }

    /**
     * 获取Criteria
     *
     * @param entityClass 泛型类
     * @param aliasName   别名
     * @param <T>         对象类型
     * @return Criteria
     */
    public <T> Criteria getCriteria(Class<T> entityClass, String aliasName) {
        return this.getSession().createCriteria(entityClass, aliasName);
    }

    /**
     * 查询相应列表
     *
     * @param criteria Criteria对象
     * @param <T>      列表类型
     * @return 查询结果列表
     */
    public <T> List<T> list(Criteria criteria) {
        return criteria.list();
    }

    /**
     * 删除一个对象
     *
     * @param entityClass 泛型类
     * @param id          主键ID
     * @param <T>         对象类型
     */
    public <T> void delete(Class<T> entityClass, Serializable id) {
        T t = get(entityClass, id);
        if (t != null) {
            this.getSession().delete(t);
        }
    }

    /**
     * 删除一个对象
     *
     * @param object 对象
     */
    public void delete(Object object) {
        this.getSession().delete(object);
    }

    /**
     * 删除一个对象
     *
     * @param object 对象
     */
    public void deleteByHibernateTemplate(Object object) {
        hibernateTemplate.delete(object);
    }

    /**
     * 删除对象列表
     *
     * @param entities 泛型类对象列表
     * @param <T>      集合类型
     */
    public <T> void deleteAllByHibernateTemplate(Collection<T> entities) {
        for (T t : entities) {
            this.deleteByHibernateTemplate(t);
        }
    }

    /**
     * 批量删除对象
     *
     * @param entityClass 泛型类
     * @param ids         主键ID数组
     * @param <T>         对象类型
     */
    public <T> void deleteAll(Class<T> entityClass, Serializable[] ids) {
        for (Serializable id : ids) {
            this.delete(entityClass, id);
        }
    }

    /**
     * 修改对象
     *
     * @param object 对象
     */
    public void update(Object object) {
        this.getSession().update(object);
    }

    /**
     * 添加对象,对象存在则修改对象
     *
     * @param object 对象
     */
    public void saveOrUpdate(Object object) {
        this.getSession().saveOrUpdate(object);
    }

    /**
     * 查询唯一对象
     *
     * @param hql    HQL查询语句
     * @param params 查询条件
     * @param <T>    对象类型
     * @return 查询对象
     */
    public <T> T getUniqueResultByHql(String hql, Object... params) {
        return this.getUniqueResultByHql(hql, null, params);
    }

    /**
     * 查询唯一对象，适用于自定义查询字段的情况
     *
     * @param hql    HQL查询语句
     * @param bean   自定义查询字段对应实体
     * @param params 查询条件
     * @param <T>    对象类型
     * @return 查询对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getUniqueResultByHql(String hql, Class<T> bean, Object... params) {
        Query query = this.getQuery(hql);
        setParameters(query, params);
        if (null != bean) {
            query.setResultTransformer(Transformers.aliasToBean(bean));
        }
        return (T) query.uniqueResult();
    }

    /**
     * 查询唯一对象
     *
     * @param sql    SQL查询语句
     * @param params 查询条件
     * @param <T>    泛型，实际上只会有Object和Object[]两种结果，查询单个字段时，返回类型为Object，查询多个字段时，返回类型为Object[]
     * @return 查询对象
     */
    public <T> T getUniqueResultBySql(String sql, Object... params) {
        return this.getUniqueResultBySql(sql, null, params);
    }

    /**
     * 查询唯一对象
     *
     * @param sql         SQL查询语句
     * @param entityClass 封装查询结果的实体对象<br>注：<br>1、entityClass必须为Hibernate实体类<br>2、entityClass必须被Hibernate初始化时扫描到
     * @param params      查询条件
     * @param <T>         对象类型
     * @return 查询对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getUniqueResultBySql(String sql, Class<T> entityClass, Object... params) {
        SQLQuery query = this.getSQLQuery(sql);
        this.setParameters(query, params);
        if (null != entityClass) {
            query.addEntity(entityClass);
        }
        return (T) query.uniqueResult();
    }

    /**
     * 查询唯一对象
     *
     * @param hql    HQL查询语句
     * @param params 查询条件
     * @param <T>    对象类型
     * @return 查询对象
     */
    public <T> T getUniqueResultByHql(String hql, List<Object> params) {
        return this.getUniqueResultByHql(hql, null, params);
    }

    /**
     * 查询唯一对象，适用于自定义查询字段的情况
     *
     * @param hql    HQL查询语句
     * @param bean   自定义查询字段对应实体
     * @param params 查询条件
     * @param <T>    对象类型
     * @return 查询对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getUniqueResultByHql(String hql, Class<T> bean, List<Object> params) {
        Query query = this.getQuery(hql);
        setParameters(query, params);
        if (null != bean) {
            query.setResultTransformer(Transformers.aliasToBean(bean));
        }
        return (T) query.uniqueResult();
    }

    /**
     * 查询唯一对象
     *
     * @param sql    SQL查询语句
     * @param params 查询条件
     * @param <T>    泛型，实际上只会有Object和Object[]两种结果，查询单个字段时，返回类型为Object，查询多个字段时，返回类型为Object[]
     * @return 查询对象
     */
    public <T> T getUniqueResultBySql(String sql, List<Object> params) {
        return this.getUniqueResultBySql(sql, null, params);
    }

    /**
     * 查询唯一对象
     *
     * @param sql         SQL查询语句
     * @param entityClass 封装查询结果的实体对象<br>注：<br>1、entityClass必须为Hibernate实体类<br>2、entityClass必须被Hibernate初始化时扫描到
     * @param params      查询条件
     * @param <T>         对象类型
     * @return 查询对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getUniqueResultBySql(String sql, Class<T> entityClass, List<Object> params) {
        SQLQuery query = this.getSQLQuery(sql);
        this.setParameters(query, params);
        if (null != entityClass) {
            query.addEntity(entityClass);
        }
        return (T) query.uniqueResult();
    }

    /**
     * 根据Criteria对象查询单条数据
     *
     * @param criteria       Criteria对象
     * @param projectionList 数据实体投映转换对象
     * @param cls            查询结果转换实体
     * @param <T>            泛型对象
     * @return 泛型对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getUniqueResult(Criteria criteria, Class<T> cls, ProjectionList projectionList) {
        if (null != projectionList) {
            criteria.setProjection(projectionList);
        }
        if (null != cls) {
            criteria.setResultTransformer(Transformers.aliasToBean(cls));
        }
        return (T) criteria.uniqueResult();
    }

    /**
     * 根据Criteria对象查询单条数据
     *
     * @param criteria Criteria对象
     * @param <T>      泛型对象
     * @return 泛型对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getUniqueResult(Criteria criteria) {
        return (T) criteria.uniqueResult();
    }

    /**
     * 根据Hql语句和参数条件查询对应的记录列表
     *
     * @param hql    hql语句
     * @param params 查询条件
     * @param <T>    列表类型
     * @return 泛型对象列表
     */
    public <T> List<T> listHql(String hql, Object... params) {
        return this.listHql(hql, null, params);
    }

    /**
     * 根据Hql语句和参数条件查询对应的记录列表，适用于自定义查询字段的情况
     *
     * @param hql    hql语句
     * @param bean   自定义查询字段对应实体
     * @param params 查询条件
     * @param <T>    列表类型
     * @return 泛型对象列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listHql(String hql, Class<T> bean, Object... params) {
        Query query = this.getQuery(hql);
        setParameters(query, params);
        if (null != bean) {
            query.setResultTransformer(Transformers.aliasToBean(bean));
        }
        return query.list();
    }

    /**
     * 根据Hql语句和参数条件查询对应的记录列表
     *
     * @param hql    hql语句
     * @param params 查询条件
     * @param <T>    列表类型
     * @return 泛型对象列表
     */
    public <T> List<T> listHql(String hql, List<Object> params) {
        return this.listHql(hql, null, params);
    }

    /**
     * 根据Hql语句和参数条件查询对应的记录列表，适用于自定义查询字段的情况
     *
     * @param hql    hql语句
     * @param bean   自定义查询字段对应实体
     * @param params 查询条件
     * @param <T>    列表类型
     * @return 泛型对象列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listHql(String hql, Class<T> bean, List<Object> params) {
        Query query = this.getQuery(hql);
        setParameters(query, params);
        if (null != bean) {
            query.setResultTransformer(Transformers.aliasToBean(bean));
        }
        return query.list();
    }

    /**
     * 根据Sql语句和参数条件查询对应的记录列表
     *
     * @param sql    SQL语句
     * @param params 查询条件
     * @param <T>    列表泛型，实际上只会有Object和Object[]两种结果，查询单个字段时，列表泛型为Object，查询多个字段时，列表泛型为Object[]
     * @return 泛型对象列表
     */
    public <T> List<T> listSql(String sql, Object... params) {
        return this.listSql(sql, null, params);
    }

    /**
     * 根据Criteria对象查询所有数据，不分页
     *
     * @param criteria       Criteria对象
     * @param projectionList 数据实体投映转换对象
     * @param cls            查询结果转换实体
     * @param <T>            泛型对象
     * @return 泛型对象列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listCriteria(Criteria criteria, ProjectionList projectionList, Class<T> cls) {
        if (null != projectionList) {
            criteria.setProjection(projectionList);
        }
        if (null != cls) {
            criteria.setResultTransformer(Transformers.aliasToBean(cls));
        }
        return criteria.list();
    }

    /**
     * 根据Sql语句和参数条件查询对应的记录列表
     *
     * @param sql         SQL语句
     * @param entityClass 封装查询结果的实体对象<br>注：<br>1、entityClass必须为Hibernate实体类<br>2、entityClass必须被Hibernate初始化时扫描到
     * @param params      查询条件
     * @param <T>         列表类型
     * @return 泛型对象列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listSql(String sql, Class<T> entityClass, Object... params) {
        SQLQuery query = this.getSQLQuery(sql);
        setParameters(query, params);
        if (null != entityClass) {
            query.addEntity(entityClass);
        }
        return query.list();
    }

    /**
     * 根据Sql语句和参数条件查询对应的记录列表
     *
     * @param sql    SQL语句
     * @param params 查询条件
     * @param <T>    列表泛型，实际上只会有Object和Object[]两种结果，查询单个字段时，列表泛型为Object，查询多个字段时，列表泛型为Object[]
     * @return 泛型对象列表
     */
    public <T> List<T> listSql(String sql, List<Object> params) {
        return this.listSql(sql, null, params);
    }

    /**
     * 根据Sql语句和参数条件查询对应的记录列表
     *
     * @param sql         SQL语句
     * @param entityClass 封装查询结果的实体对象<br>注：<br>1、entityClass必须为Hibernate实体类<br>2、entityClass必须被Hibernate初始化时扫描到
     * @param params      查询条件
     * @param <T>         列表类型
     * @return 泛型对象列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listSql(String sql, Class<T> entityClass, List<Object> params) {
        SQLQuery query = this.getSQLQuery(sql);
        setParameters(query, params);
        if (null != entityClass) {
            query.addEntity(entityClass);
        }
        return query.list();
    }

    /**
     * 将HQL语句转换成SQL语句
     *
     * @param hql hql
     * @return 转换后的SQL语句
     */
    protected String hqlToSql(String hql) {
        QueryTranslatorImpl queryTranslator = new QueryTranslatorImpl(hql, hql, Collections.EMPTY_MAP, (SessionFactoryImplementor) sessionFactory);

        queryTranslator.compile(Collections.EMPTY_MAP, false);
        return queryTranslator.getSQLString();
    }

    /**
     * 获取当前查询的记录数
     *
     * @param hql    查询语句
     * @param isHql  是否是HQL, true：是，false：否
     * @param params 查询条件
     * @return 查询结果
     */
    public long findCount(String hql, boolean isHql, Object... params) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(*) from (");
        if (isHql) {
            builder.append(hqlToSql(hql));
        } else {
            builder.append(hql);
        }
        String sql = builder.append(") totalModel").toString();
        SQLQuery query = this.getSQLQuery(sql);
        this.setParameters(query, params);
        BigInteger count = (BigInteger) query.uniqueResult();
        return count.longValue();
    }

    /**
     * 获取当前查询的记录数
     *
     * @param hql    查询语句
     * @param isHql  是否是HQL, true：是，false：否
     * @param params 查询条件
     * @return 查询结果
     */
    public long findCount(String hql, boolean isHql, List<Object> params) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(*) from (");
        if (isHql) {
            builder.append(hqlToSql(hql));
        } else {
            builder.append(hql);
        }
        String sql = builder.append(") totalModel").toString();
        SQLQuery query = this.getSQLQuery(sql);
        this.setParameters(query, params);
        BigInteger count = (BigInteger) query.uniqueResult();
        return count.longValue();
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param criteria 封装好的criteria对象
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param <T>      列表类型
     * @return 分页查询结果列表
     */
    public <T> List<T> findPagerData(Criteria criteria, Integer beginNum, Integer showNum) {
        return this.findPagerData(null, null, criteria, beginNum, showNum);
    }

    /**
     * 分页获取符合条件的查询记录，适用于自定义查询字段的情况
     *
     * @param projectionList 查询字段投影对象
     * @param bean           查询字段对应实体
     * @param criteria       封装好的criteria对象
     * @param beginNum       起始记录数
     * @param showNum        展示条数
     * @param <T>            查询字段实体泛型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerData(ProjectionList projectionList, Class<T> bean, Criteria criteria, Integer beginNum, Integer showNum) {
        if (null != projectionList) {
            // 设置投影字段
            criteria.setProjection(projectionList);
        }
        if (null != bean) {
            // 设置投影字段映射对象
            criteria.setResultTransformer(Transformers.aliasToBean(bean));
        }
        criteria.setFirstResult(beginNum);
        criteria.setMaxResults(showNum);
        return criteria.list();
    }

    /**
     * 分页获取符合条件的查询记录，适用于自定义查询字段的情况
     *
     * @param projectionList 查询字段投影对象
     * @param bean           查询字段对应实体
     * @param dc             封装好的DetachedCriteria对象
     * @param beginNum       起始记录数
     * @param showNum        展示条数
     * @param <T>            查询字段实体泛型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> Pager<T> findPagerData(ProjectionList projectionList, Class<T> bean, DetachedCriteria dc, Integer beginNum, Integer showNum) {
        if (null != projectionList) {
            // 设置投影字段
            dc.setProjection(projectionList);
        }
        if (null != bean) {
            // 设置投影字段映射对象
            dc.setResultTransformer(Transformers.aliasToBean(bean));
        }
        List<T> rows = findPagerData(dc, beginNum, showNum);
        long total = this.findCount(dc);
        return new Pager<T>(total, rows);
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param hql      hql语句
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param params   查询条件
     * @param <T>      列表类型
     * @return 分页查询结果列表
     */
    public <T> List<T> findPagerDataByHql(String hql, Integer beginNum, Integer showNum, Object... params) {
        return this.findPagerDataByHql(hql, null, beginNum, showNum, params);
    }

    /**
     * 分页获取符合条件的查询记录，适用于自定义查询字段的情况
     *
     * @param hql      hql语句
     * @param bean     自定义查询字段对应实体
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param <T>      查询字段实体泛型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerDataByHql(String hql, Class<T> bean, Integer beginNum, Integer showNum, Object... params) {
        Query query = this.getQuery(hql);
        if (null != bean) {
            query.setResultTransformer(Transformers.aliasToBean(bean));
        }
        // 开始获取数据的位置
        query.setFirstResult(beginNum);
        // 获取多少条记录
        query.setMaxResults(showNum);
        // 是否有查询条件
        this.setParameters(query, params);
        return query.list();
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param sql      sql语句
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param params   查询条件
     * @param <T>      列表泛型，实际上只会有Object和Object[]两种结果，查询单个字段时，列表泛型为Object，查询多个字段时，列表泛型为Object[]
     * @return 分页查询结果列表
     */
    public <T> List<T> findPagerDataBySql(String sql, Integer beginNum, Integer showNum, Object... params) {
        return this.findPagerDataBySql(sql, null, beginNum, showNum, params);
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param sql         sql语句
     * @param entityClass 封装查询结果的实体对象<br>注：<br>1、entityClass必须为Hibernate实体类<br>2、entityClass必须被Hibernate初始化时扫描到
     * @param beginNum    起始记录数
     * @param showNum     展示条数
     * @param params      查询条件
     * @param <T>         列表类型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerDataBySql(String sql, Class<T> entityClass, Integer beginNum, Integer showNum, Object... params) {
        SQLQuery query = this.getSQLQuery(sql);
        // 开始获取数据的位置
        query.setFirstResult(beginNum);
        // 获取多少条记录
        query.setMaxResults(showNum);
        // 是否有查询条件
        this.setParameters(query, params);
        // 设置查询映射对象
        if (null != entityClass) {
            query.addEntity(entityClass);
        }
        return query.list();
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param hql      hql语句
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param params   查询条件
     * @param <T>      列表类型
     * @return 分页查询结果列表
     */
    public <T> List<T> findPagerDataByHql(String hql, Integer beginNum, Integer showNum, List<Object> params) {
        return this.findPagerDataByHql(hql, null, beginNum, showNum, params);
    }

    /**
     * 分页获取符合条件的查询记录，适用于自定义查询字段的情况
     *
     * @param hql      hql语句
     * @param bean     自定义查询字段对应实体
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param <T>      查询字段实体泛型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerDataByHql(String hql, Class<T> bean, Integer beginNum, Integer showNum, List<Object> params) {
        Query query = this.getQuery(hql);
        if (null != bean) {
            query.setResultTransformer(Transformers.aliasToBean(bean));
        }
        // 开始获取数据的位置
        query.setFirstResult(beginNum);
        // 获取多少条记录
        query.setMaxResults(showNum);
        // 是否有查询条件
        this.setParameters(query, params);
        return query.list();
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param sql      sql语句
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param params   查询条件
     * @param <T>      列表泛型，实际上只会有Object和Object[]两种结果，查询单个字段时，列表泛型为Object，查询多个字段时，列表泛型为Object[]
     * @return 分页查询结果列表
     */
    public <T> List<T> findPagerDataBySql(String sql, Integer beginNum, Integer showNum, List<Object> params) {
        return this.findPagerDataBySql(sql, null, beginNum, showNum, params);
    }

    /**
     * 分页获取符合条件的查询记录
     *
     * @param sql         sql语句
     * @param entityClass 封装查询结果的实体对象<br>注：<br>1、entityClass必须为Hibernate实体类<br>2、entityClass必须被Hibernate初始化时扫描到
     * @param beginNum    起始记录数
     * @param showNum     展示条数
     * @param params      查询条件
     * @param <T>         列表类型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerDataBySql(String sql, Class<T> entityClass, Integer beginNum, Integer showNum, List<Object> params) {
        SQLQuery query = this.getSQLQuery(sql);
        // 开始获取数据的位置
        query.setFirstResult(beginNum);
        // 获取多少条记录
        query.setMaxResults(showNum);
        // 是否有查询条件
        this.setParameters(query, params);
        // 设置查询映射对象
        if (null != entityClass) {
            query.addEntity(entityClass);
        }
        return query.list();
    }

    /**
     * 分页获取符合条件的查询记录，将查询结果映射为MAP.
     *
     * @param projectionList 查询字段投影对象
     * @param criteria       封装好的criteria对象
     * @param beginNum       起始记录数
     * @param showNum        展示条数
     * @param <T>            查询字段实体泛型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("all")
    public <T> List<T> findPagerDataByMap(ProjectionList projectionList, Criteria criteria, Integer beginNum, Integer showNum) {
        if (null != projectionList) {
            // 设置投影字段
            criteria.setProjection(projectionList);
        }
        criteria.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        criteria.setFirstResult(beginNum);
        criteria.setMaxResults(showNum);
        return criteria.list();
    }

    /**
     * 设置投影查询字段
     *
     * @param propertyMap    字段Map<br></br>
     *                       Key：Hibernate数据模型字段，value：查询结果映射实体字段
     * @param projectionList ProjectionList对象
     * @return ProjectionList对象
     */
    public ProjectionList setProjectionsProperty(Map<String, String> propertyMap, ProjectionList projectionList) {
        if (CollectionUtils.isNull(propertyMap)) {
            return projectionList;
        }
        for (Map.Entry<String, String> e : propertyMap.entrySet()) {
            projectionList.add(Projections.property(e.getKey()), e.getValue());
        }
        return projectionList;
    }

    /**
     * 调用存储过程
     *
     * @param work 原生JDBC存储过程执行对象
     */
    public void callProcedure(Work work) {
        this.getSession().doWork(work);
    }

    /**
     * 查询全部列表
     *
     * @param entityClass 泛型类
     * @param <T>         列表类型
     * @return 查询结果列表
     */
    public <T> List<T> listByHibernateTemplate(Class<T> entityClass) {
        return hibernateTemplate.loadAll(entityClass);
    }

    /**
     * 查询全部列表
     *
     * @param entityClass 泛型类
     * @param <T>         列表类型
     * @return 查询结果列表
     */
    public <T> List<T> list(Class<T> entityClass) {
        return this.getCriteria(entityClass).list();
    }

    /**
     * 获取单个对象
     *
     * @param entityClass 泛型类
     * @param id          主键ID
     * @param <T>         对象类型
     * @return 泛型对象
     */
    public <T> T getByHibernateTemplate(Class<T> entityClass, Serializable id) {
        return hibernateTemplate.get(entityClass, id);
    }

    /**
     * 获取单个对象
     *
     * @param entityClass 泛型类
     * @param id          主键ID
     * @param <T>         对象类型
     * @return 泛型对象
     */
    @SuppressWarnings("unchecked")
    public <T> T get(Class<T> entityClass, Serializable id) {
        return (T) this.getSession().get(entityClass, id);
    }

    /**
     * 根据主键ID数组查询列表
     *
     * @param entityClass 实体类
     * @param ids         主键ID数组
     * @param <T>         列表类型
     * @return 查询列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listByHibernateTemplate(Class<T> entityClass, Serializable[] ids) {
        DetachedCriteria dc = DetachedCriteria.forClass(entityClass);
        dc.add(Restrictions.in("id", ids)).addOrder(Order.asc("id"));
        return hibernateTemplate.findByCriteria(dc);
    }

    /**
     * 根据主键ID数组查询列表
     *
     * @param entityClass 实体类
     * @param ids         主键ID数组
     * @param <T>         列表类型
     * @return 查询列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> listByCriteria(Class<T> entityClass, Serializable[] ids) {
        Criteria criteria = this.getCriteria(entityClass);
        criteria.add(Restrictions.in("id", ids)).addOrder(Order.asc("id"));
        return criteria.list();
    }

    /**
     * 删除一个对象
     *
     * @param entityClass 泛型类
     * @param id          主键ID
     * @param <T>         对象类型
     */
    public <T> void deleteByHibernateTemplate(Class<T> entityClass, Serializable id) {
        T t = get(entityClass, id);
        if (t == null) {
            throw new RuntimeException("the object is not found, id : " + id);
        }
        hibernateTemplate.delete(t);
    }

    /**
     * 删除对象列表
     *
     * @param entities 泛型类对象列表
     * @param <T>      集合类型
     */
    public <T> void deleteAll(Collection<T> entities) {
        hibernateTemplate.deleteAll(entities);
    }

    /**
     * 保存对象
     *
     * @param object 对象
     */
    public void saveByHibernateTemplate(Object object) {
        hibernateTemplate.save(object);
    }

    /**
     * 保存对象
     *
     * @param object 对象
     */
    public Serializable save(Object object) {
        return this.getSession().save(object);
    }

    /**
     * 修改对象
     *
     * @param object 对象
     */
    public void updateByHibernateTemplate(Object object) {
        hibernateTemplate.update(object);
    }

    /**
     * 添加对象,对象存在则修改对象
     *
     * @param object 对象
     */
    public void saveOrUpdateByHibernateTemplate(Object object) {
        hibernateTemplate.saveOrUpdate(object);
    }

    /**
     * 通过查询语句执行操作
     *
     * @param hql     操作语句
     * @param isHql   是否是HQL，true：是，false：否
     * @param objects 操作参数
     */
    public void executeUpdate(String hql, boolean isHql, Object... objects) {
        Query query = null;
        if (isHql) {
            query = this.getQuery(hql);
        } else {
            query = this.getSQLQuery(hql);
        }

        this.setParameters(query, objects);
        query.executeUpdate();
    }

    /**
     * 通过查询语句执行操作
     *
     * @param hql     操作语句
     * @param isHql   是否是HQL，true：是，false：否
     * @param objects 操作参数
     */
    public void executeUpdate(String hql, boolean isHql, List<Object> objects) {
        Query query = null;
        if (isHql) {
            query = this.getQuery(hql);
        } else {
            query = this.getSQLQuery(hql);
        }
        this.setParameters(query, objects);
        query.executeUpdate();
    }

    /**
     * 查询唯一对象
     *
     * @param detachedCriteria 封装好的criteria对象
     * @param <T>              对象类型
     * @return 查询对象
     */
    public <T> T getUniqueResult(final DetachedCriteria detachedCriteria) {
        T t = hibernateTemplate.execute(new HibernateCallback<T>() {
            public T doInHibernate(Session session) throws HibernateException {
                Criteria criteria = detachedCriteria.getExecutableCriteria(session);
                return (T) criteria.uniqueResult();
            }
        });

        return t;
    }

    /**
     * 查询唯一对象
     *
     * @param hql     查询语句
     * @param isHql   是否是HQL，true：是，false：否
     * @param objects 查询条件
     * @param <T>     对象类型
     * @return 查询对象
     */
    public <T> T getUniqueResult(String hql, boolean isHql, Object... objects) {
        Query query = null;
        if (isHql) {
            query = this.getQuery(hql);
        } else {
            query = this.getSQLQuery(hql);
        }

        this.setParameters(query, objects);
        return (T) query.uniqueResult();
    }

    /**
     * 查询唯一对象
     *
     * @param hql     查询语句
     * @param isHql   是否是HQL，true：是，false：否
     * @param objects 查询条件
     * @param <T>     对象类型
     * @return 查询对象
     */
    public <T> T getUniqueResult(String hql, boolean isHql, List<Object> objects) {
        Query query = null;
        if (isHql) {
            query = this.getQuery(hql);
        } else {
            query = this.getSQLQuery(hql);
        }

        this.setParameters(query, objects);
        return (T) query.uniqueResult();
    }

    /**
     * 按照条件查询对象列表
     *
     * @param hql     hql
     * @param objects 条件列表
     * @param <T>     列表类型
     * @return 查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findHqlAll(String hql, Object... objects) {
        return hibernateTemplate.find(hql, objects);
    }

    /**
     * 无分页根据criteria对象查询
     *
     * @param detachedCriteria 封装好的criteria对象
     * @param <T>              列表类型
     * @return 对象查询结果
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findCriteriaAll(DetachedCriteria detachedCriteria) {
        return hibernateTemplate.findByCriteria(detachedCriteria);
    }

    /**
     * 无分页根据criteria对象查询总数
     *
     * @param criteria 封装好的criteria对象
     * @return 查询结果
     */
    public long findCount(Criteria criteria) {
        criteria.setFirstResult(0);
        Long count = (Long) criteria.setProjection(Projections.rowCount()).uniqueResult();
        return count.longValue();
    }

    /**
     * 无分页根据criteria对象查询总数
     *
     * @param detachedCriteria 封装好的离线criteria对象
     * @return 查询结果
     */
    public long findCount(final DetachedCriteria detachedCriteria) {
        Long count = hibernateTemplate.execute(new HibernateCallback<Long>() {
            public Long doInHibernate(Session session) throws HibernateException {
                Criteria criteria = detachedCriteria.getExecutableCriteria(session);
                criteria.setFirstResult(0);
                return (Long) criteria.setProjection(Projections.rowCount()).uniqueResult();
            }
        });

        return count.longValue();
    }

    /**
     * 设置查询参数
     *
     * @param query  query对象
     * @param params 查询条件
     */
    public void setParameters(Query query, Object... params) {
        if (CollectionUtils.notNull(params)) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i, params[i]);
            }
        }
    }

    /**
     * 设置查询参数
     *
     * @param query   query对象
     * @param objects 查询条件
     */
    public void setParameters(Query query, List<Object> objects) {
        if (CollectionUtils.notNull(objects)) {
            for (int i = 0; i < objects.size(); i++) {
                query.setParameter(i, objects.get(i));
            }
        }
    }

    /**
     * 获取当前查询的记录数
     *
     * @param hql     hql
     * @param objects 查询条件
     * @return 查询结果
     */
    public long findCount(String hql, Object... objects) {
        StringBuilder builder = new StringBuilder();
        String sql = builder.append("select count(*) from (").append(hqlToSql(hql)).append(") o").toString();
        SQLQuery query = this.getSQLQuery(sql);
        this.setParameters(query, objects);
        BigInteger count = (BigInteger) query.uniqueResult();
        return count.longValue();
    }

    /**
     * 获取当前查询的记录数
     *
     * @param hql     hql
     * @param objects 查询条件
     * @return 查询结果
     */
    public long findCount(String hql, List<Object> objects) {
        StringBuilder builder = new StringBuilder();
        String sql = builder.append("select count(*) from (").append(hqlToSql(hql)).append(") o").toString();
        SQLQuery query = this.getSQLQuery(sql);
        this.setParameters(query, objects);
        BigInteger count = (BigInteger) query.uniqueResult();
        return count.longValue();
    }

    /**
     * 获取符合条件的查询记录
     *
     * @param detachedCriteria 封装好的离线criteria对象
     * @param beginNum         起始记录数
     * @param showNum          展示条数
     * @param <T>              列表类型
     * @return 查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerData(DetachedCriteria detachedCriteria, int beginNum, int showNum) {
        List<T> list = hibernateTemplate.findByCriteria(detachedCriteria, beginNum, showNum);
        return list;
    }

    /**
     * 获取符合条件的查询记录
     *
     * @param hql      hql
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param objects  查询条件
     * @param <T>      列表类型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerData(String hql, Integer beginNum, Integer showNum, Object... objects) {
        Query query = this.getQuery(hql);
        // 开始获取数据的位置
        query.setFirstResult(beginNum);
        // 获取多少条记录
        query.setMaxResults(showNum);
        // 是否有查询条件
        this.setParameters(query, objects);
        return query.list();
    }

    /**
     * 获取符合条件的查询记录
     *
     * @param hql      hql
     * @param beginNum 起始记录数
     * @param showNum  展示条数
     * @param objects  查询条件
     * @param <T>      列表类型
     * @return 分页查询结果列表
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> findPagerData(String hql, Integer beginNum, Integer showNum, List<Object> objects) {
        Query query = this.getQuery(hql);
        // 开始获取数据的位置
        query.setFirstResult(beginNum);
        // 获取多少条记录
        query.setMaxResults(showNum);
        // 是否有查询条件
        this.setParameters(query, objects);
        return query.list();
    }
}
