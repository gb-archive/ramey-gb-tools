/* Test unary minus

    lefttype: char, short, long
    resulttype: char, short, long
    storage: static,
    attr: volatile,
 */
#include <testfwk.h>

void
testUMinus(void)
{
  {storage} {attr} {lefttype} left;
  {storage} {attr} {resulttype} result;

  left = 53;
  result = -left;

  ASSERT(result == -53);

  left = -76;
  result = -left;

  ASSERT(result == 76);
}
