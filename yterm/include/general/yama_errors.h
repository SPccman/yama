/**
 * File              : yama_errors.h
 * Author            : 42 <chenchao@ztgame.com>
 * Date              : 23.02.2021
 * Last Modified Date: 23.02.2021
 * Last Modified By  : 42 <chenchao@ztgame.com>
 */

#pragma once

enum YAMA_ERROR_TYPE {
    EN_YAMA_SUCCESS = 0,    //success

    // tcp
    EN_YAMA_ERR_TCP_LISTEN_FAILED   = -1,   // listen failed
    EN_YAMA_ERR_TCP_ADDR_FAILED     = -2,   // transfer addr failed
    EN_YAMA_ERR_TCP_BIND_FAILED     = -3,   // bind failed
    EN_YAMA_ERR_TCP_FD_FAILED       = -4,   // get fd failed
    EN_YAMA_ERR_TCP_ACCEPT_FAILED   = -5,   // accept failed


    //sys
    EN_YAMA_ERR_NIL                 = -100, // a nill pointer
};
