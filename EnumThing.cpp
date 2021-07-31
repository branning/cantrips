
#include <iostream>
#include <ostream>

struct Thing {
    enum Enum { FIRST, SECOND, THIRD } _thing;

    operator const Thing::Enum() const { return _thing; };

    friend std::ostream& operator<<(std::ostream& os, const Thing& t)
    {
        Enum thing { t };
        switch(thing) {
        case FIRST:
            os << "First ";
            break;
        case SECOND:
            os << "Second ";
            break;
        case THIRD:
            os << "Third ";
            break;
        }
        os << "Thing";
        return os;
    };
};


enum Thing2 { FIRST, SECOND, THIRD };

std::ostream& operator<<(std::ostream& os, const Thing2& thing)
{
    switch(thing) {
    case FIRST:
        os << "First ";
        break;
    case SECOND:
        os << "Second ";
        break;
    case THIRD:
        os << "Third ";
        break;
    }
    os << "Thing";
    return os;
};

int main(void)
{
	Thing t { Thing::Enum::FIRST };
	Thing2 t2 { THIRD };
	std::cout << "Hello! Thing is " << t << std::endl;
	std::cout << "And another thing is " << t2 << std::endl;
	return 0;
}