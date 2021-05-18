---
name: Bug report
about: Create a report to help us improve

---
[linuxserverurl]: https://linuxserver.io
[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

<!--- If you are new to Docker or this application our issue tracker is **ONLY** used for reporting bugs or requesting features. Please use [our discord server](https://discord.gg/YWrKVTn) for general support. --->

<!--- Provide a general summary of the bug in the Title above -->

------------------------------

## Expected Behavior
Until vesion nightly-5470acd3-ls58 I have no problem running the container on one QNAP TS-253B firmware version 4.5.3.1632.
Since this version, deploing the container using Portainer (Recreate -> Pull latest image), the installation don't end correctly (loop).
 
## Current Behavior
Unable to end the installation procedure (loop).

## Steps to Reproduce
Simply updatating my installation using Portainer (Recreate -> Pull latest image).


## Environment
**OS:** QNAP NAS TS-253B 
**CPU architecture:** x86_64
**How docker service was installed:**
Pulling the latest image from official docker repo
<!--- Providing context helps us come up with a solution that is most useful in the real world -->

## Command used to create docker container (run/create/compose/screenshot)
<!--- Provide your docker create/run command or compose yaml snippet, or a screenshot of settings if using a gui to create the container -->

## Docker logs
The above exception was the direct cause of the following exception:                                                                                                                                                                            
                                                                                                                                                                                                                                               
Traceback (most recent call last):                                                                                                                                                                                                              
  File "/app/calibre-web/cps.py", line 34, in <module>                                                                                                                                                                                          
    from cps import create_app                                                                                                                                                                                                                  
  File "/app/calibre-web/cps/__init__.py", line 73, in <module>                                                                                                                                                                                 
    ub.init_db(cli.settingspath)                                                                                                                                                                                                                
  File "/app/calibre-web/cps/ub.py", line 678, in init_db                                                                                                                                                                                       
    migrate_Database(session)                                                                                                                                                                                                                   
  File "/app/calibre-web/cps/ub.py", line 562, in migrate_Database                                                                                                                                                                              
    if session.query(User).filter(User.role.op('&')(constants.ROLE_ANONYMOUS) == constants.ROLE_ANONYMOUS).first() \                                                                                                                            
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/orm/query.py", line 3429, in first                                                                                                                                                    
    ret = list(self[0:1])                                                                                                                                                                                                                       
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/orm/query.py", line 3203, in __getitem__                                                                                                                                              
    return list(res)                                                                                                                                                                                                                            
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/orm/query.py", line 3535, in __iter__                                                                                                                                                 
    return self._execute_and_instances(context)                                                                                                                                                                                                 
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/orm/query.py", line 3560, in _execute_and_instances                                                                                                                                   
    result = conn.execute(querycontext.statement, self._params)                                                                                                                                                                                 
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/engine/base.py", line 1011, in execute                                                                                                                                                
    return meth(self, multiparams, params)                                                                                                                                                                                                      
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/sql/elements.py", line 298, in _execute_on_connection                                                                                                                                 
    return connection._execute_clauseelement(self, multiparams, params)                                                                                                                                                                         
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/engine/base.py", line 1124, in _execute_clauseelement                                                                                                                                 
    ret = self._execute_context(                                                                                                                                                                                                                
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/engine/base.py", line 1316, in _execute_context                                                                                                                                       
    self._handle_dbapi_exception(                                                                                                                                                                                                               
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/engine/base.py", line 1510, in _handle_dbapi_exception                                                                                                                                
    util.raise_(                                                                                                                                                                                                                                
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/util/compat.py", line 182, in raise_                                                                                                                                                  
    raise exception                                                                                                                                                                                                                             
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/engine/base.py", line 1276, in _execute_context                                                                                                                                       
    self.dialect.do_execute(                                                                                                                                                                                                                    
  File "/usr/local/lib/python3.8/dist-packages/sqlalchemy/engine/default.py", line 608, in do_execute                                                                                                                                           
    cursor.execute(statement, parameters)                                                                                                                                                                                                       
sqlalchemy.exc.OperationalError: (sqlite3.OperationalError) no such column: user.nickname                                                                                                                                                       
[SQL: SELECT user.id AS user_id, user.nickname AS user_nickname, user.email AS user_email, user.role AS user_role, user.password AS user_password, user.kindle_mail AS user_kindle_mail, user.locale AS user_locale, user.sidebar_view AS user_s
idebar_view, user.default_language AS user_default_language, user.mature_content AS user_mature_content, user.denied_tags AS user_denied_tags, user.allowed_tags AS user_allowed_tags, user.denied_column_value AS user_denied_column_value, use
r.allowed_column_value AS user_allowed_column_value, user.view_settings AS user_view_settings                                                                                                                                                   
FROM user                                                                                                                                                                                                                                       
WHERE (user.role & ?) = ?                                                                                                                                                                                                                       
 LIMIT ? OFFSET ?]                                                                                                                                                                                                                              
[parameters: (32, 32, 1, 0)]                                                                                                                                                                                                                    
(Background on this error at: http://sqlalche.me/e/13/e3q8)         
