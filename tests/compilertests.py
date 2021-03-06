import unittest
from asmjit import *
import ctypes
import array

class TestCompiler(unittest.TestCase):
    def testBasicCompiler(self):
        c = Compiler()
        c.newFunction(CALL_CONV_DEFAULT, UIntFunctionBuilder0());

        c.nop()
        c.nop()
        c.nop()

        address = GPVar(c.newGP())
        c.mov(address, imm(432))
        c.ret(address)
        c.endFunction()

        raw_ptr  = int(c.make())
        var = GPVar()
        print 'Generated function at %x' % (raw_ptr,)

        restype = ctypes.c_uint
        argtypes = []
        functype = ctypes.CFUNCTYPE(restype, *argtypes)
        func = functype(raw_ptr)
        ret = func()
        self.assertEqual(ret, 432, 'Compiler function did not return 432')

