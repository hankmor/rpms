package dendy.rpms.service;

import dendy.rpms.domain.HouseEntity;
import dendy.rpms.entity.House;
import dendy.rpms.page.Pager;
import dendy.rpms.query.HouseQuery;

/**
 * 圈舍管理服务接口
 *
 * @author Dendy
 * @since 2013-10-11下午2:03:35
 */
public interface IHouseService {
    /**
     * 根据id获取圈舍
     *
     * @param id
     * @return
     */
    House get(Long id);

    /**
     * 根据编号获取
     *
     * @param no
     * @return
     */
    House getByNo(String no);

    /**
     * 修改
     *
     * @param house
     */
    void update(House house);

    /**
     * 添加
     *
     * @param house
     */
    void add(House house);

    /**
     * 删除
     *
     * @param ids
     */
    void delete(String ids);

    /**
     * 分页查询
     *
     * @param houseQuery
     * @return
     */
    Pager<HouseEntity> page(HouseQuery houseQuery);

    /**
     * 添加成员
     *
     * @param houseId 圈舍id
     * @param ids     成员ids
     */
    void addMembers(Long houseId, String ids);

    /**
     * 删除成员
     *
     * @param houseId 圈舍id
     * @param ids     成员ids
     */
    void deleteMembers(Long houseId, String ids);
}
