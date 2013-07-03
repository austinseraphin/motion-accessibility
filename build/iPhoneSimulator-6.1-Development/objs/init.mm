extern "C" {
    void ruby_sysinit(int *, char ***);
    void ruby_init(void);
    void ruby_init_loadpath(void);
    void ruby_script(const char *);
    void ruby_set_argv(int, char **);
    void rb_vm_init_compiler(void);
    void rb_vm_init_jit(void);
    void rb_vm_aot_feature_provide(const char *, void *);
    void *rb_vm_top_self(void);
    void rb_define_global_const(const char *, void *);
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
void MREP_24D4D1258864477C99D71FDB422C86C9(void *, void *);
void MREP_855774601C9745C99411D8E700A95360(void *, void *);
void MREP_E8657B31F40249768CF69ADDB1729BE6(void *, void *);
void MREP_5B3D011EC8D54F0DAAF2B853467B21BF(void *, void *);
void MREP_F05F1174D77341D490B335AE1C632A6F(void *, void *);
void MREP_CD75FB42FA6E43229527748F743C950F(void *, void *);
void MREP_5325321CC9574B89993DA207A58B5E78(void *, void *);
}

extern "C"
void
RubyMotionInit(int argc, char **argv)
{
    static bool initialized = false;
    if (!initialized) {
	ruby_init();
	ruby_init_loadpath();
        if (argc > 0) {
	    const char *progname = argv[0];
	    ruby_script(progname);
	}
#if !__LP64__
	try {
#endif
	    void *self = rb_vm_top_self();
rb_define_global_const("RUBYMOTION_ENV", @"development");
rb_define_global_const("RUBYMOTION_VERSION", @"2.3");
MREP_24D4D1258864477C99D71FDB422C86C9(self, 0);
MREP_855774601C9745C99411D8E700A95360(self, 0);
MREP_E8657B31F40249768CF69ADDB1729BE6(self, 0);
MREP_5B3D011EC8D54F0DAAF2B853467B21BF(self, 0);
MREP_F05F1174D77341D490B335AE1C632A6F(self, 0);
MREP_CD75FB42FA6E43229527748F743C950F(self, 0);
MREP_5325321CC9574B89993DA207A58B5E78(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
