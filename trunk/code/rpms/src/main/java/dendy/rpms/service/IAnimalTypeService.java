package dendy.rpms.service;

import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.entity.AnimalType;
import dendy.rpms.page.Pager;
import dendy.rpms.query.AnimalTypeQuery;

import java.util.List;

/**
 * 动物类型服务接口
 *
 * @author Dendy
 * @since 2013-10-11下午2:03:35
 */
public interface IAnimalTypeService {
    /**
     * 根据id获取
     *
     * @param id
     * @return
     */
    AnimalType get(Long id);

    /**
     * 修改
     *
     * @param animalType
     */
    void update(AnimalType animalType);

    /**
     * 添加
     *
     * @param animalType
     */
    void add(AnimalType animalType);

    /**
     * 删除
     *
     * @param ids
     */
    void delete(String ids);

    /**
     * 分页查询
     *
     * @param animalTypeQuery
     * @return
     */
    Pager<AnimalTypeEntity> page(AnimalTypeQuery animalTypeQuery);

    List<AnimalTypeEntity> list();
}
