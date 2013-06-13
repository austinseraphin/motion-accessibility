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
void MREP_A847313272304D2C9048ED3121270603(void *, void *);
void MREP_668C8CAE61894941974AF89CB2CFDB92(void *, void *);
void MREP_61CC75681C284EA091E3BF49AC18834F(void *, void *);
void MREP_418ACC43BD1C473F9F64666247DAA408(void *, void *);
void MREP_E61CA3DD6DF84165B6AF8361CBB4EDC1(void *, void *);
void MREP_13CF6D3CC435430CA9D7412F2857897A(void *, void *);
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
MREP_A847313272304D2C9048ED3121270603(self, 0);
MREP_668C8CAE61894941974AF89CB2CFDB92(self, 0);
MREP_61CC75681C284EA091E3BF49AC18834F(self, 0);
MREP_418ACC43BD1C473F9F64666247DAA408(self, 0);
MREP_E61CA3DD6DF84165B6AF8361CBB4EDC1(self, 0);
MREP_13CF6D3CC435430CA9D7412F2857897A(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
