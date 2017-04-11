package dendy.rpms.service;

import dendy.rpms.domain.AnimalEntity;
import dendy.rpms.domain.AttaEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.AnimalGenotype;
import dendy.rpms.entity.Atta;
import dendy.rpms.page.Pager;
import dendy.rpms.query.AnimalQuery;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * 小熊猫管理服务接口
 *
 * @author Dendy
 * @since 2013-10-11下午2:03:35
 */
public interface IAnimalService {
	/**
	 * 根据id获取
	 *
	 * @param id
	 * @return
	 */
	Animal get(Long id);

	/**
	 * 根据电子芯片好获取
	 *
	 * @param no
	 * @return
	 */
	Animal getByMicrochipCode(String no);

	/**
	 * 根据编号获取
	 *
	 * @param no
	 * @return
	 */
	Animal getByNo(String no);

	/**
	 * 修改
	 *
	 * @param animal
	 */
	void update(Animal animal);

	/**
	 * 添加
	 *
	 * @param animal
	 */
	void add(Animal animal);

	/**
	 * 删除
	 *
	 * @param ids
	 */
	void delete(String ids);

	/**
	 * 分页查询
	 *
	 * @param animalQuery
	 * @return
	 */
	Pager<AnimalEntity> page(AnimalQuery animalQuery);

	/**
	 * 标记动物为死亡状态.
	 *
	 * @param ids
	 * @param animal
	 */
	void mark(String ids, Animal animal);

	/**
	 * 添加基因型数据
	 *
	 * @param id       动物id
	 * @param primerNo 引物编号
	 * @param codeA    基因型A
	 * @param codeB    基因型B
	 */
	void addGenotypes(Long id, String primerNo, String codeA, String codeB);

	/**
	 * 添加基因型数据
	 *
	 * @param animalNo 动物编号
	 * @param primerNo 引物编号
	 * @param codeA    基因型A
	 * @param codeB    基因型B
	 */
	void addGenotypes(String animalNo, String primerNo, String codeA, String codeB);

	/**
	 * 删除基因型数据
	 *
	 * @param id  动物id
	 * @param ids 基因型ids
	 */
	void deleteGenotypes(Long id, String ids);

	/**
	 * 上传照片.
	 *
	 * @param animalId 动物id
	 * @param atta     附件
	 * @param photo    照片
	 */
	void uploadPhoto(Long animalId, Atta atta, MultipartFile photo) throws IOException;

	/**
	 * 删除照片
	 *
	 * @param animalId 动物id
	 * @param ids      照片ids
	 */
	void deletePhotos(Long animalId, String ids);

	/**
	 * 查询动物的所有照片信息.
	 *
	 * @param animalId 动物id
	 * @return 照片列表
	 */
	List<AttaEntity> listAttas(Long animalId);

	/**
	 * 查询动物并获取其基因型
	 *
	 * @param id
	 * @return
	 */
	Animal getWithGenotypes(Long id);

	/**
	 * 根据动物id和引物id获取基因型数据
	 *
	 * @param animalId
	 * @param primerId
	 * @return
	 */
	AnimalGenotype getGenotype(Long animalId, Long primerId);
}
