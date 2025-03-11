package com.umu.prompts.infrastructure.api.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonValue;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * The type of the database
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2025-03-11T17:59:49.331557300+01:00[Europe/Madrid]", comments = "Generator version: 7.7.0")
public enum DataBaseTypeDTO {
  
  MY_SQL("MySQL"),
  
  POSTGRE_SQL("PostgreSQL"),
  
  SQ_LITE("SQLite"),
  
  ORACLE_DB("OracleDB"),
  
  MICROSOFT_SQL_SERVER("MicrosoftSQLServer"),
  
  MARIA_DB("MariaDB"),
  
  IBMDB2("IBMDB2"),
  
  AMAZON_RDS("AmazonRDS"),
  
  GOOGLE_CLOUD_SQL("GoogleCloudSQL"),
  
  SAP_HANA("SAPHana"),
  
  MONGO_DB("MongoDB"),
  
  COUCH_DB("CouchDB"),
  
  CASSANDRA("Cassandra"),
  
  REDIS("Redis"),
  
  COUCHBASE("Couchbase"),
  
  DYNAMO_DB("DynamoDB"),
  
  NEO4J("Neo4j"),
  
  RIAK("Riak"),
  
  H_BASE("HBase"),
  
  ELASTICSEARCH("Elasticsearch"),
  
  INFLUX_DB("InfluxDB"),
  
  TIMESCALE_DB("TimescaleDB"),
  
  OPEN_TSDB("OpenTSDB"),
  
  DB4O("db4o"),
  
  OBJECT_DB("ObjectDB"),
  
  GOOGLE_SPANNER("GoogleSpanner"),
  
  COCKROACH_DB("CockroachDB"),
  
  TI_DB("TiDB"),
  
  MEMCACHED("Memcached"),
  
  BERKELEY_DB("BerkeleyDB"),
  
  SCYLLA_DB("ScyllaDB"),
  
  ARANGO_DB("ArangoDB"),
  
  ORIENT_DB("OrientDB"),
  
  MARK_LOGIC("MarkLogic"),
  
  GOOGLE_BIGTABLE("GoogleBigtable");

  private String value;

  DataBaseTypeDTO(String value) {
    this.value = value;
  }

  @JsonValue
  public String getValue() {
    return value;
  }

  @Override
  public String toString() {
    return String.valueOf(value);
  }

  @JsonCreator
  public static DataBaseTypeDTO fromValue(String value) {
    for (DataBaseTypeDTO b : DataBaseTypeDTO.values()) {
      if (b.value.equals(value)) {
        return b;
      }
    }
    throw new IllegalArgumentException("Unexpected value '" + value + "'");
  }
}

