package dendy.rpms.service;

import dendy.rpms.entity.Atta;

/**
 * <p>Created by Dendy on 2014/9/6.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public interface IAttaService {
    /**
     * 根据id获取
     *
     * @param id
     * @return
     */
    Atta get(Long id);

    /**
     * 修改
     *
     * @param atta
     */
    void update(Atta atta);

    /**
     * 添加
     *
     * @param atta
     */
    void add(Atta atta);

    /**
     * 删除
     *
     * @param ids
     */
    void delete(String ids);
}
