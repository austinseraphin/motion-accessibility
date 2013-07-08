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
void MREP_455E76A1DDE14620A7BB1CF30DF09E7E(void *, void *);
void MREP_ECE37C9C5A5D452BB9F2F2CE3D41FC2C(void *, void *);
void MREP_393E0B9ED4E245879902D22CCB197A6F(void *, void *);
void MREP_ECE4837EACBA4670AFB3D574DB781D62(void *, void *);
void MREP_6CF6B21E0B544489A85D087A34FA4126(void *, void *);
void MREP_B1CA3A9A4E784250969F7D8E144EA7FB(void *, void *);
void MREP_47B8872DCE744368A4382A26EB6D6087(void *, void *);
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
rb_define_global_const("RUBYMOTION_ENV", @"development");
rb_define_global_const("RUBYMOTION_VERSION", @"2.3");
MREP_24D4D1258864477C99D71FDB422C86C9(self, 0);
MREP_455E76A1DDE14620A7BB1CF30DF09E7E(self, 0);
MREP_ECE37C9C5A5D452BB9F2F2CE3D41FC2C(self, 0);
MREP_393E0B9ED4E245879902D22CCB197A6F(self, 0);
MREP_ECE4837EACBA4670AFB3D574DB781D62(self, 0);
MREP_6CF6B21E0B544489A85D087A34FA4126(self, 0);
MREP_B1CA3A9A4E784250969F7D8E144EA7FB(self, 0);
MREP_47B8872DCE744368A4382A26EB6D6087(self, 0);
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
