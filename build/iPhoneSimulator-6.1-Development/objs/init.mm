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
void MREP_6B3C2E300F3646C7848E7327133ACD0E(void *, void *);
void MREP_C6ABB26C5819448A826FA8EB8A60369C(void *, void *);
void MREP_393E0B9ED4E245879902D22CCB197A6F(void *, void *);
void MREP_5B3D011EC8D54F0DAAF2B853467B21BF(void *, void *);
void MREP_9AF00FE67E8044E1B2431A48817450FB(void *, void *);
void MREP_ECE4837EACBA4670AFB3D574DB781D62(void *, void *);
void MREP_DA8C681406374F8C9FB7BD63552F279E(void *, void *);
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
MREP_6B3C2E300F3646C7848E7327133ACD0E(self, 0);
MREP_C6ABB26C5819448A826FA8EB8A60369C(self, 0);
MREP_393E0B9ED4E245879902D22CCB197A6F(self, 0);
MREP_5B3D011EC8D54F0DAAF2B853467B21BF(self, 0);
MREP_9AF00FE67E8044E1B2431A48817450FB(self, 0);
MREP_ECE4837EACBA4670AFB3D574DB781D62(self, 0);
MREP_DA8C681406374F8C9FB7BD63552F279E(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
