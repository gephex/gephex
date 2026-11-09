/* This source file is a part of the GePhex Project.

 Copyright (C) 2001-2004

 Georg Seidel <georg@gephex.org> 
 Martin Bayer <martin@gephex.org> 
 Phillip Promesberger <coma@gephex.org>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.*/

#include <cstring>
#include "unboundednumberview.h"

#include <sstream>
#include <cmath>

#include <QtCore/QLocale>
#include <QtGui/qvalidator.h>
#include <QtWidgets/qlineedit.h>
#include <QtWidgets/QHBoxLayout>

#include <utils/structreader.h>
#include <utils/buffer.h>

namespace gui
{

  /**
   * Input, output and validation follow the users locale (e.g. "0,1" with
   * a german locale). The engine on the other hand reads and writes numbers
   * in the "C" locale (atof() and "%.14g" in numbertype.h), so the value is
   * converted on the way to and from the engine.
   */
  class UnboundedNumberView: public gui::TypeView
  {
    Q_OBJECT
  public:
    UnboundedNumberView(QWidget* parent, const ParamMap& params)
      : TypeView(parent, params), m_value(-1.0)
    {
      utils::StructReader sr(params);
      m_lineEdit = new QLineEdit(this);

      m_layout->addWidget(m_lineEdit);

      m_precision = sr.getIntValue("precision", 6);
      std::string display_format = sr.getStringValue("display_format",
                                                     "auto");
      if (display_format == "fixed")
        m_format = 'f';
      else if (display_format == "scientific")
        m_format = 'e';
      else
        m_format = 'g';

      // no thousands separators in the display, they only get in the way
      // when the value is edited
      m_locale.setNumberOptions(QLocale::OmitGroupSeparator);

      QDoubleValidator* validator = new QDoubleValidator(this);
      validator->setLocale(m_locale);
      m_lineEdit->setValidator(validator);

      connect(m_lineEdit, SIGNAL(returnPressed()),
	      this, SLOT(lineeditChanged()));
    }
		
    virtual ~UnboundedNumberView() {}
		
		
    virtual void valueChange(const utils::Buffer& newValue)
    {
      // the engine sends the value in the "C" locale
      std::string doof = reinterpret_cast<const char*>(newValue.getPtr());
      std::istringstream is(doof);
      double value = 0;
      is >> value;

	  if (fabs(value - m_value) > 0.00001)
	  {
		  m_value = value;
		  m_lineEdit->setText(m_locale.toString(value, m_format,
		                                        m_precision));
	  }
    }

public slots:
    void lineeditChanged()
    {
      bool ok = false;
      double value = m_locale.toDouble(m_lineEdit->text(), &ok);
      if (!ok)
        return;

      // the engine expects the "C" locale
      QByteArray raw = QByteArray::number(value, 'g', 15);
      const char* text = raw.constData();

      utils::Buffer 
	b = utils::Buffer(reinterpret_cast<const unsigned char*>(text),
			  strlen(text)+1);

      emit valueChanged(b);
    }
		
  private:
    QLineEdit* m_lineEdit;
    double m_value;
    QLocale m_locale;
    char m_format;
    int m_precision;
  };

  // constructor

  UnboundedNumberViewConstructor::UnboundedNumberViewConstructor()
    : TypeViewConstructor("number input", "unboundednumber_selector")
  {
  }

  TypeView* UnboundedNumberViewConstructor::construct(QWidget* parent,
						      const ParamMap& params)
    const
  {
    return new UnboundedNumberView(parent, params);
  }
}

#include "unboundednumberview_moc_cpp.cpp"
