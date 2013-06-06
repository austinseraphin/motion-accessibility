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
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
void MREP_DAD030A9A43145FEA41A169F05671316(void *, void *);
void MREP_43B0C2B17AC84579BEC788C6EA70C0A2(void *, void *);
void MREP_8A961669BE5441E0A74151B61511896A(void *, void *);
void MREP_EF8AED63C2104CDCB9AB5C6C2EC023D8(void *, void *);
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
MREP_DAD030A9A43145FEA41A169F05671316(self, 0);
MREP_43B0C2B17AC84579BEC788C6EA70C0A2(self, 0);
MREP_8A961669BE5441E0A74151B61511896A(self, 0);
MREP_EF8AED63C2104CDCB9AB5C6C2EC023D8(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
