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
void MREP_AA484A325E484A64B6C56361733882EF(void *, void *);
void MREP_7E1AABABA8AA433DBB6FC6A5ED490FD6(void *, void *);
void MREP_16A03D7C3F314F018FD8CD0AB9EAB1BE(void *, void *);
void MREP_13910C8E00DF40179CF64C1A04869D8D(void *, void *);
void MREP_3674553FBB9640E699DBA66CFA120937(void *, void *);
void MREP_B1CA3A9A4E784250969F7D8E144EA7FB(void *, void *);
void MREP_F90CCAA8018A4825BFF53CDC82DC49B6(void *, void *);
void MREP_2D7D66EA6B074FD0B281D033F9F1A380(void *, void *);
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
rb_define_global_const("RUBYMOTION_ENV", @"test");
rb_define_global_const("RUBYMOTION_VERSION", @"2.3");
MREP_AA484A325E484A64B6C56361733882EF(self, 0);
MREP_7E1AABABA8AA433DBB6FC6A5ED490FD6(self, 0);
MREP_16A03D7C3F314F018FD8CD0AB9EAB1BE(self, 0);
MREP_13910C8E00DF40179CF64C1A04869D8D(self, 0);
MREP_3674553FBB9640E699DBA66CFA120937(self, 0);
MREP_B1CA3A9A4E784250969F7D8E144EA7FB(self, 0);
MREP_F90CCAA8018A4825BFF53CDC82DC49B6(self, 0);
MREP_2D7D66EA6B074FD0B281D033F9F1A380(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
