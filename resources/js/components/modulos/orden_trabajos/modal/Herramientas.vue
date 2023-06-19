<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <b-skeleton-wrapper
                        :loading="!oOrdenGenerada"
                        class="w-100"
                    >
                        <template #loading>
                            <b-skeleton-table
                                :rows="3"
                                :columns="3"
                                :table-props="{ bordered: true, striped: true }"
                            >
                            </b-skeleton-table>
                        </template>
                        <form v-if="oOrdenGenerada">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger':
                                                errors.herramienta_id,
                                        }"
                                        >Seleccionar Herramienta*</label
                                    >
                                    <el-select
                                        placeholder="Seleccionar Herramienta"
                                        class="w-100"
                                        :class="{
                                            'is-invalid': errors.herramienta_id,
                                        }"
                                        v-model="herramienta_id"
                                        filterable
                                        clearable
                                        @change="
                                            detectaHerramienta();
                                            calculaTotal();
                                        "
                                    >
                                        <el-option
                                            v-for="(
                                                item, index
                                            ) in listHerramientas"
                                            :key="index"
                                            :value="item.id"
                                            :label="item.full_name"
                                        ></el-option>
                                    </el-select>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.herramienta_id"
                                        v-text="errors.herramienta_id[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger':
                                                errors.cantidad_solicitada,
                                        }"
                                        >Cantidad solicitada*</label
                                    >
                                    <input
                                        type="number"
                                        class="form-control"
                                        :class="{
                                            'is-invalid':
                                                errors.cantidad_solicitada,
                                        }"
                                        v-model="cantidad_solicitada"
                                        @change="calculaTotal"
                                        @keyup="calculaTotal"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.cantidad_solicitada"
                                        v-text="errors.cantidad_solicitada[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.costo,
                                        }"
                                        >Costo*</label
                                    >
                                    <el-input
                                        :class="{
                                            'is-invalid': errors.costo,
                                        }"
                                        v-model="oHerramienta.costo"
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.costo"
                                        v-text="errors.costo[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.total,
                                        }"
                                        >Total
                                        <small>(Automático)</small>*</label
                                    >
                                    <el-input
                                        :class="{
                                            'is-invalid': errors.total,
                                        }"
                                        v-model="total"
                                        readonly
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.total"
                                        v-text="errors.total[0]"
                                    ></span>
                                </div>
                                <div class="col-md-12">
                                    <button
                                        type="button"
                                        class="btn btn-primary btn-flat btn-block"
                                        :disabled="validaInfo"
                                        @click="agregarHerramienta"
                                    >
                                        <i class="fa fa-plus"></i> Agregar a la
                                        lista
                                    </button>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-md-12">
                                    <h4
                                        class="font-weight-bold text-center text-lg"
                                    >
                                        Lista de herramientas
                                    </h4>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Herramienta</th>
                                                <th>Cantidad solicitada</th>
                                                <th>Costo</th>
                                                <th>Total</th>
                                                <th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    oOrdenGenerada
                                                        .detalle_herramientas
                                                        .length > 0
                                                "
                                            >
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oOrdenGenerada.detalle_herramientas"
                                                    :key="index"
                                                >
                                                    <td>{{ index + 1 }}</td>
                                                    <td>
                                                        {{
                                                            item.herramienta
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.cantidad_solicitada
                                                        }}
                                                    </td>
                                                    <td>{{ item.costo }}</td>
                                                    <td>{{ item.total }}</td>
                                                    <td>
                                                        <button
                                                            type="button"
                                                            class="btn btn-danger btn-xs"
                                                            @click="
                                                                eliminarHerramienta(
                                                                    index,
                                                                    item.id
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
                                                            ></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </template>
                                            <template v-else>
                                                <tr>
                                                    <td
                                                        colspan="6"
                                                        class="text-center font-italic text-gray"
                                                    >
                                                        NO SE AGREGÓ NINGÚN
                                                        REGISTRO
                                                    </td>
                                                </tr>
                                            </template>
                                            <tr>
                                                <td
                                                    colspan="4"
                                                    class="font-weight-bold text-right"
                                                >
                                                    TOTAL
                                                </td>
                                                <td class="font-weight-bold">
                                                    {{ sumaTotal }}
                                                </td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </form>
                    </b-skeleton-wrapper>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cancelar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        orden_trabajo: {
            type: Object,
            default: {
                id: 0,
                fecha_programada: "",
                subunidad_id: "",
                gama_id: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                estado: "",
                orden_generada: {
                    id: 0,
                    archivo: "",
                    descripcion_documentacion: "",
                    comentario: "",
                    detalle_herramientas: [],
                    detalle_herramientas: [],
                    detalle_personals: [],
                },
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            this.oOrdenGenerada = null;
            if (newVal) {
                this.bModal = true;
                this.herramienta_id = "";
                this.total = 0;
                this.eliminados = [];
                this.oHerramienta = {
                    id: "",
                    costo: 0,
                };
                this.getOrdengenerada();
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            return "HERRAMIENTAS";
        },
        textoBoton() {
            return "Guardar cambios";
        },
        validaInfo() {
            if (
                this.herramienta_id &&
                this.cantidad_solicitada &&
                this.cantidad_solicitada > 0
            ) {
                return false;
            }
            return true;
        },
        sumaTotal() {
            let sumatoria = 0;
            sumatoria = 0;
            if (this.oOrdenGenerada.detalle_herramientas.length > 0) {
                this.oOrdenGenerada.detalle_herramientas.forEach((elem) => {
                    sumatoria += parseFloat(elem.total);
                });
            }
            return sumatoria;
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oOrdenGenerada: null,
            listHerramientas: [],
            oHerramienta: {
                id: "",
                costo: 0,
            },
            herramienta_id: "",
            cantidad_solicitada: 0,
            total: 0,
            eliminados: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getHerramientas();
    },
    methods: {
        getHerramientas() {
            axios.get("/admin/herramientas").then((response) => {
                this.listHerramientas = response.data.herramientas;
            });
        },
        getOrdengenerada() {
            axios
                .get(
                    "/admin/orden_generadas/getByOrdenTrabajo/" +
                        this.orden_trabajo.id
                )
                .then((response) => {
                    this.oOrdenGenerada = response.data;
                });
        },
        detectaHerramienta() {
            if (this.herramienta_id != "") {
                this.oHerramienta = this.listHerramientas.filter((elem) => {
                    return elem.id == this.herramienta_id;
                })[0];
            } else {
                this.herramienta_id = "";
                this.oHerramienta = {
                    id: "",
                    costo: 0,
                };
            }
        },
        agregarHerramienta() {
            this.oOrdenGenerada.detalle_herramientas.push({
                id: 0,
                orden_generada_id: this.oOrdenGenerada.id,
                herramienta_id: this.herramienta_id,
                cantidad_solicitada: this.cantidad_solicitada,
                costo: this.oHerramienta.costo,
                total: this.total,
                herramienta: this.oHerramienta,
            });
            this.herramienta_id = "";
            this.detectaHerramienta();
            this.total = 0;
            this.cantidad_solicitada = 0;
        },
        calculaTotal() {
            if (
                this.herramienta_id &&
                this.cantidad_solicitada &&
                this.cantidad_solicitada > 0
            ) {
                this.total =
                    parseFloat(this.cantidad_solicitada) *
                    parseFloat(this.oHerramienta.costo);
                this.total = parseFloat(this.total).toFixed();
            } else {
                this.total = 0;
            }
        },
        eliminarHerramienta(index, id) {
            if (id != 0) {
                this.eliminados.push(id);
            }
            this.oOrdenGenerada.detalle_herramientas.splice(index, 1);
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                if (this.eliminados.length > 0) {
                    this.oOrdenGenerada.eliminados = this.eliminados;
                }
                let url =
                    "/admin/detalle_herramientas/store/" +
                    this.oOrdenGenerada.id;
                axios
                    .post(url, this.oOrdenGenerada)
                    .then((response) => {
                        this.enviando = false;
                        if (response.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            console.log(response.data);
                            this.$emit(
                                "envioModal",
                                response.data.orden_generada
                            );
                            this.limpiaModal();
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: response.data.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaModal() {
            this.errors = [];
        },
    },
};
</script>

<style></style>
