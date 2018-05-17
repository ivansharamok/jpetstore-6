/**
 *    Copyright 2010-2018 the original author or authors.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.mybatis.jpetstore.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.jpetstore.domain.Account;
import org.mybatis.jpetstore.mapper.AccountMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class AccountRepository {
  @Autowired
  private JdbcTemplate jdbcTemplate;

  private static final String SQL = "select * from ACCOUNT";

  public List<Account> getAccounts() {
    List<Account> accounts = new ArrayList<Account>();
    List<Map<String, Object>> rows = jdbcTemplate.queryForList(SQL);

    for (Map<String, Object> row : rows) {
      Account account = new Account();
      account.setFirstName((String) row.get("firstname"));
      account.setLastName((String) row.get("lastname"));
      account.setCountry((String) row.get("country"));

      accounts.add(account);
    }

    return accounts;
  }
}