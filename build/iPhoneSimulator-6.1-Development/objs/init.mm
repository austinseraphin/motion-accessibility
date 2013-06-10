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
void MREP_A9BD8BF0FC9E467587FEDB0C965D0FD0(void *, void *);
void MREP_0B453F823066424987B781B039234A0C(void *, void *);
void MREP_893F49F3CB8844099751081B740AA678(void *, void *);
void MREP_E5E0594EC41E45A3B9F3B15F60D39488(void *, void *);
void MREP_218450C74110400D8254A71808429BA4(void *, void *);
void MREP_2979306710C94F16822483EAD879DD0F(void *, void *);
void MREP_BB85C8332CDD4E88BB5F26283D5DDCCB(void *, void *);
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
MREP_A9BD8BF0FC9E467587FEDB0C965D0FD0(self, 0);
MREP_0B453F823066424987B781B039234A0C(self, 0);
MREP_893F49F3CB8844099751081B740AA678(self, 0);
MREP_E5E0594EC41E45A3B9F3B15F60D39488(self, 0);
MREP_218450C74110400D8254A71808429BA4(self, 0);
MREP_2979306710C94F16822483EAD879DD0F(self, 0);
MREP_BB85C8332CDD4E88BB5F26283D5DDCCB(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
