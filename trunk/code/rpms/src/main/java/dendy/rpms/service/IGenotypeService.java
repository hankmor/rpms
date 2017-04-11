package dendy.rpms.service;

import dendy.rpms.domain.GenotypeEntity;
import dendy.rpms.entity.Genotype;
import dendy.rpms.page.Pager;
import dendy.rpms.query.GenotypeQuery;

import java.util.List;

/**
 * 引物管理服务接口
 *
 * @author Dendy
 * @since 2013-10-11下午2:03:35
 */
public interface IGenotypeService {
    /**
     * 根据id获取圈舍
     *
     * @param id
     * @return
     */
    Genotype get(Long id);

    /**
     * 修改
     *
     * @param Genotype
     */
    void update(Genotype Genotype);

    /**
     * 添加
     *
     * @param Genotype
     */
    void add(Genotype Genotype);

    /**
     * 删除
     *
     * @param ids
     */
    void delete(String ids);

    /**
     * 分页查询
     *
     * @param GenotypeQuery
     * @return
     */
    Pager<GenotypeEntity> page(GenotypeQuery GenotypeQuery);

    /**
     * 根据编号获取
     *
     * @param no
     * @param primerNo
     * @return
     */
    Genotype getByNo(String no, String primerNo);

    /**
     * 查询引物下的所有基因型编号
     *
     * @param primerNo 基因型no
     * @param code     查询过滤条件，eg : %12%
     * @return
     */
    List<GenotypeEntity> listAll(String primerNo, String code);
}
