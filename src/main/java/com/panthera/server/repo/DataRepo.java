package com.panthera.server.repo;

import com.panthera.server.model.DataEntity;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface DataRepo extends MongoRepository<DataEntity, String> {
}
