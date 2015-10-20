#include <hx/CFFI.h>

extern "C" {

    void facebook_main() {
        val_int(0);
    }
    DEFINE_ENTRY_POINT(facebook_main);
    
    int facebook_register_prims(){return 0;}
}