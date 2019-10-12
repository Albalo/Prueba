defmodule CodeGenerator do
  def generate_code(ast) do
    post_order(ast)
  end

  def post_order(node) do
    case node do
      nil ->
        nil


      ast_node ->
        code_snippet = post_order(ast_node.left_node)
        # TODO: Falta terminar de implementar cuando el arbol tiene mas ramas
        post_order(ast_node.right_node)
        emit_code(ast_node.node_name, code_snippet, ast_node.value)
    end
  end

  def emit_code(:program, code_snippet, _) do
    """
	       .globl	main
    """ <>
      code_snippet
  end

  def emit_code(:function, code_snippet, :main) do
    """
    main:
    """ <>
      code_snippet
  end

  def emit_code(:return, code_snippet, _) do
    code_snippet<>
    """
        ret
    """
  end
  def emit_code(:unary_negative, code_snippet, _) do
    code_snippet<>
    """
        neg	%eax
    """
  end
  def emit_code(:unary_complement, code_snippet, _) do
    code_snippet<>
    """
        not	%eax
    """
  end
  def emit_code(:negative_logical, code_snippet, _) do
    code_snippet<>
    """
    cmpl     $0, %eax
    movl     $0, %eax
    sete     %al
    """
  end

  def emit_code(:addition, code_snippet, _) do
    code_snippet<>
    """
    pop     %rcx
    add     %rcx, %rax
    """
  end

  def emit_code(:negative_keyword, code_snippet, _) do
  code_snippet<> 
  """
      pop     %rcx
      sub     %rax, %rcx
      mov     %rcx, %rax
  """
end
 
  def emit_code(:multiplication, code_snippet, _) do
    code_snippet<>
    """
    pop     %rcx
    imul    %rcx, %rax
    """
  end
   
  def emit_code(:division, code_snippet, _) do
    code_snippet<>
    """
    pop         %ecx
    div         %ecx
    """
  end


  def emit_code(:constant, _code_snippet, value) do

    """
        movl	$#{value}, %eax
    """
  end

 
end