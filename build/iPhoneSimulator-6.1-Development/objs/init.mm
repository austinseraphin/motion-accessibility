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
void MREP_1CD40CE77C2546B5995FF0842E92EF6C(void *, void *);
void MREP_C4CE69BEA8044CB49E5B7FCCDB34C6E1(void *, void *);
void MREP_F6C594A2F2294F40B3308688C1C06D2C(void *, void *);
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
MREP_1CD40CE77C2546B5995FF0842E92EF6C(self, 0);
MREP_C4CE69BEA8044CB49E5B7FCCDB34C6E1(self, 0);
MREP_F6C594A2F2294F40B3308688C1C06D2C(self, 0);
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
