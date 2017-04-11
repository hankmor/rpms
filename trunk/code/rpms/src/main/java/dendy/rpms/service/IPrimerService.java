package dendy.rpms.service;

import dendy.rpms.domain.PrimerEntity;
import dendy.rpms.entity.Primer;
import dendy.rpms.page.Pager;
import dendy.rpms.query.PrimerQuery;

/**
 * 引物管理服务接口
 *
 * @author Dendy
 * @since 2013-10-11下午2:03:35
 */
public interface IPrimerService {
    /**
     * 根据id获取圈舍
     *
     * @param id
     * @return
     */
    Primer get(Long id);

    /**
     * 根据编号获取
     *
     * @param no
     * @return
     */
    Primer getByNo(String no);

    /**
     * 修改
     *
     * @param Primer
     */
    void update(Primer Primer);

    /**
     * 添加
     *
     * @param Primer
     */
    void add(Primer Primer);

    /**
     * 删除
     *
     * @param ids
     */
    void delete(String ids);

    /**
     * 分页查询
     *
     * @param PrimerQuery
     * @return
     */
    Pager<PrimerEntity> page(PrimerQuery PrimerQuery);
}
