package dendy.rpms.service;

import dendy.rpms.domain.StudbookData;

/**
 * <p>Created by Dendy on 2014/9/21.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public interface IAnimalStudbookService {
    StudbookData loadDown(Long animalId);

    StudbookData loadUp(Long animalId);
}
